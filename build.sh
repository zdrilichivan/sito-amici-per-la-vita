#!/bin/bash
# Prepara la cartella dist/ da pubblicare su Cloudflare Pages.
#
# Finché il sito non ha i dati veri dei gatti, alla radice del dominio va la
# pagina di attesa: qui diventa index.html, e le si toglie il meta robots
# perché sul dominio vero deve essere indicizzabile (al contrario
# dell'anteprima su GitHub Pages, che resta noindex).
#
# Uso:  ./build.sh          poi:  wrangler pages deploy dist
set -euo pipefail
cd "$(dirname "$0")"

rm -rf dist
mkdir -p dist

# la pagina di attesa diventa la home, senza il blocco ai motori
sed '/name="robots"/d; /pagina temporanea: fuori dai motori/d' \
    work-in-progress.html > dist/index.html

# pagina di errore: senza, Pages risponde 200 con la home a ogni indirizzo
# sbagliato, e i motori indicizzerebbero URL fantasma
cp 404.html dist/404.html

cp -R assets dist/assets
mkdir -p dist/immagini

# Le foto vanno online in WebP: stessa qualità, circa il 38% di peso in meno.
# I sorgenti restano JPEG, che è il formato con cui arrivano dall'associazione.
if command -v cwebp >/dev/null 2>&1; then
  for f in immagini/*.jpg; do
    cwebp -quiet -q 82 "$f" -o "dist/immagini/$(basename "${f%.jpg}").webp"
  done
  # i riferimenti nelle pagine puntano ai .webp
  sed -i '' 's|\(immagini/[a-z0-9-]*\)\.jpg|\1.webp|g' dist/index.html dist/404.html
else
  echo "  cwebp assente: pubblico i JPEG"
  cp immagini/*.jpg dist/immagini/
fi

# cache lunga per le risorse statiche: non cambiano mai, e senza questo
# il browser le richiede di nuovo ogni quattro ore
cat > dist/_headers <<'HDR'
/immagini/*
  Cache-Control: public, max-age=31536000, immutable
/assets/*
  Cache-Control: public, max-age=31536000, immutable
HDR

echo "dist pronta:"
echo "  pagine:   $(find dist -name '*.html' | wc -l | tr -d ' ')"
echo "  immagini: $(find dist/immagini -type f | wc -l | tr -d ' ') ($(ls dist/immagini | head -1 | sed 's/.*\.//'))"
echo "  peso:     $(du -sh dist | cut -f1)"
if grep -q 'name="robots"' dist/index.html; then
  echo "  ATTENZIONE: il meta robots è ancora presente"; exit 1
fi
echo "  meta robots rimosso: sì"
