# A.mici per la vita Brescia ODV — sito

Dimostrazione grafica gratuita per l'associazione. **Non è un sito commissionato**: serve a mostrare
all'associazione come potrebbe essere il loro sito.

## Regola principale: niente dati inventati spacciati per veri

Tutti i contenuti sono di esempio e la pagina lo dichiara nella barra in cima
(`.demo-bar`). Quando si toccano i testi:

- Usare **solo** informazioni confermate dall'utente. Non cercare dati dell'associazione
  sul web e non dedurli.
- Non inserire numeri precisi che invecchiano in fretta (quanti gatti sono ospiti oggi,
  quanti ne sono stati adottati). Si è scelto di usare valori "morbidi" — *oltre 300*,
  *circa 40*, *circa 15* — proprio per non dover aggiornare la pagina di continuo e non
  mostrare un dato palesemente vecchio.
- I recapiti nella sezione contatti (indirizzo, telefono, email, Instagram e **IBAN**) sono
  quelli **veri** dell'associazione. Non modificarli, non completarli a intuito e non
  aggiungerne altri: se serve un dato che non c'è, chiederlo.
- **Due nomi, due usi.** La denominazione registrata è *A.MICI PER LA VITA — ORGANIZZAZIONE
  DI VOLONTARIATO* (iscritta al RUNTS, sezione ETS) e va usata solo dove compaiono i dati
  fiscali, cioè la riga in fondo al footer. Ovunque altro — titolo, meta, testi, footer
  descrittivo — si usa il nome con cui sono conosciuti, *A.mici per la vita Brescia ODV*,
  coerente con la loro email e i loro profili social. "Brescia" serve a distinguerli dagli
  altri "amici per la vita", ma non fa parte della denominazione legale: non aggiungerlo
  accanto al codice fiscale.
- Codice fiscale, partita IVA, IBAN e sede sono **confermati** dall'associazione
  (2 settembre 2026): `98186780171` vale sia da codice fiscale sia da partita IVA — sono
  lo stesso numero — e la sede legale coincide con quella operativa della Casa Felina,
  Via Rose 12/a, 25126 Brescia.

## Struttura

Un solo file, senza build e senza dipendenze: si apre direttamente nel browser.

```
index.html               tutta la pagina: HTML + CSS + JS inline
assets/                  logo in varie versioni (svg preferito, jpg di riserva)
immagini/                foto per il web, lato lungo 1200px
immagini/originali/      le foto come arrivate dall'associazione, mai referenziate dal sito
logo.jpg                 originale del logo
robots.txt               tiene l'anteprima fuori dai motori di ricerca
```

## Pubblicazione

Il sito è su GitHub Pages, dal branch `main` del repo `zdrilichivan/sito-amici-per-la-vita`.
È un'**anteprima non ufficiale**: non è il sito dell'associazione e non è stato approvato da
loro. Per questo la pagina ha `<meta name="robots" content="noindex…">` e c'è un `robots.txt`
che blocca tutti i crawler — non rimuoverli.

La sezione contatti contiene **recapiti veri** dell'associazione, IBAN compreso. Prima di
qualsiasi modifica lì, chiedere: sono dati di un ente reale su una pagina che l'ente non
controlla.

`work-in-progress.html` è la pagina di attesa da mettere sul dominio vero appena sarà attivo,
finché il sito non ha i dati reali dei gatti. È **esclusa da GitHub Pages** tramite
`_config.yml`: resta versionata ma non viene servita dall'anteprima. I suoi percorsi sono
relativi alla radice del repo, quindi non va spostata in una sottocartella senza correggerli.

### Pubblicazione sul dominio (Cloudflare)

Il sito vero sta su **Cloudflare Pages**, progetto `amiciperlavitabrescia`
(https://amiciperlavitabrescia.pages.dev). Si pubblica così:

```bash
./build.sh                                             # prepara dist/
wrangler pages deploy dist --project-name=amiciperlavitabrescia --branch=main
```

`build.sh` NON pubblica il repo così com'è: prende `work-in-progress.html`, lo rinomina
`index.html` e gli toglie il `<meta name="robots">` — sul dominio la pagina di attesa deve
essere indicizzabile. Copia `404.html`, `assets/` e **solo** le immagini web: gli originali
in `immagini/originali/` restano fuori dal sito pubblico. `dist/` è generata, non versionata.

Il `404.html` non è un vezzo: senza, Pages risponde `200` con la home a qualsiasi indirizzo
sbagliato, e i motori indicizzerebbero URL inesistenti come copie della home.

### Quando si passa al dominio vero

1. Togliere `robots.txt` e il `<meta name="robots">` da `index.html`: servono solo a tenere
   l'anteprima fuori dai motori.
2. Togliere il `<meta name="robots">` anche da `work-in-progress.html`. **Questa pagina, sul
   dominio, deve essere indicizzabile**: è il contrario di quanto vale ora su GitHub Pages.
   Su un dominio nuovo una pagina con denominazione, contatti e indirizzo aiuta i motori a
   capire di chi è il dominio, e chi cerca l'associazione trova almeno i recapiti.
3. Rimuovere `_config.yml`, che serve solo all'anteprima.
4. Impostare il redirect 301 da `amiciperlavitabrescia.com` a `amiciperlavitabrescia.it`.

### Foto

Le foto in `immagini/` sono **reali**, scattate al gattile: gatti che sono ospiti adesso e
altri che lo sono stati. Sono foto d'ambiente, **non schede di adozione**.

Per questo stanno solo nell'hero e nella sezione galleria `#galleria`. Le schede dei gatti
in `#mici` (Nina, Pepe, Milo…) hanno nomi e storie **inventati** e usano i visetti
illustrati in SVG (`<use href="#i-faccia">`): abbinare una foto vera a un nome di fantasia
darebbe l'impressione di un annuncio di adozione reale. Non farlo.

Aggiungere una foto:

```bash
# l'originale in immagini/originali/, poi la versione web
sips -Z 1200 -s format jpeg -s formatOptions 58 immagini/originali/NOME.jpg --out immagini/NOME.jpg
```

Poi un `<figure>` nella galleria con `width`/`height` reali, `loading="lazy"` e un `alt`
che descriva la foto. La galleria è a colonne (`column-count`), quindi non serve un numero
preciso di foto perché il layout stia in piedi.

## Convenzioni

- Testi in italiano, tono caldo e diretto, mai burocratico. Frasi brevi.
- Palette e font sono variabili CSS in `:root` — usare quelle, non colori scritti a mano.
- Ogni immagine ha `width` e `height` reali, per non far saltare il layout in caricamento.
- Il sito deve restare apribile da file locale: niente build, niente `fetch` di file esterni
  (il browser li blocca su `file://`).

## Trappole già incontrate

- **`.menu a` batte `.btn`** per specificità: un pulsante dentro il menu va vestito con
  `.menu a.btn`, altrimenti eredita `padding:4px 0` e il testo esce dalla pillola.
- **Il menu orizzontale non entra sotto i 1000px**: l'hamburger scatta a `max-width:1000px`,
  non a 720. Aggiungendo voci al menu, ricontrollare quella soglia.
- L'altezza della barra (`.nav-in`, 90px) e l'offset del menu mobile (`inset:90px…`) vanno
  tenuti allineati a mano.

## Verificare una modifica

Da `file://` le immagini si vedono; per una prova fedele conviene comunque un server:

```bash
python3 -m http.server 8777    # poi http://localhost:8777/
```

Da controllare dopo modifiche al layout: nessuno scroll orizzontale, il pulsante
"Sostienici" con il testo dentro la pillola, e le quattro celle dei numeri allineate fra loro.
