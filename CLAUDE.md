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
- **Da validare prima della messa online:** il codice fiscale `98186780171` (2 settembre 2026)
  è stato trovato cercando, non fornito dall'associazione. Ha la cifra di controllo corretta,
  ma questo prova solo che è ben formato, non che sia il loro. Su quel numero passa il 5×1000:
  se è di un altro ente le donazioni finiscono altrove. Va fatto confermare dal presidente.

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
