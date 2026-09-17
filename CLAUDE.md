# A.mici per la vita Brescia ODV — sito vetrina

Il 17 settembre 2026 Ivan ha autorizzato la pubblicazione del sito completo su Cloudflare,
sostituendo le schede dei gatti con il rimando a Instagram. Conservare grafica e foto reali.
Non aggiungere schede da aggiornare, contatori, testimonianze inventate o moduli dimostrativi.
I contatti diretti sono WhatsApp, telefono ed email. Non modificare recapiti e IBAN senza richiesta.
I dettagli delle adozioni e i nuovi arrivi vengono pubblicati su Instagram.

## Pubblicazione

Progetto Cloudflare Pages: `amiciperlavitabrescia`, branch di produzione `main`.
`./build.sh` prepara `dist/` da `index.html`, converte le foto in WebP se cwebp è disponibile,
esclude gli originali e rimuove noindex solo dalla build del dominio ufficiale.
`wrangler pages deploy dist --project-name=amiciperlavitabrescia --branch=main`

Il sorgente conserva noindex e robots.txt per l’anteprima GitHub Pages.
`work-in-progress.html` resta in archivio e non viene pubblicata.

## Dati e immagini

Recapiti, IBAN, C.F./P.IVA 98186780171 e sede Via Rose 12/a a Brescia sono confermati.
Le foto sono reali ma includono anche gatti già adottati: sono foto del rifugio, non annunci.
Usare solo dati confermati, senza promettere disponibilità, tempi o servizi non verificati.
Denominazione legale nel footer; altrove A.mici per la vita Brescia ODV.

## Verifica

Controllare immagini, link interni, menu mobile, FAQ, contatti diretti e assenza di overflow.
La pagina 404 deve restituire HTTP 404. Mantenere palette, font e layout esistenti.

## Dominio Pages

Il dominio `amiciperlavitabrescia.pages.dev` e i suoi sottodomini reindirizzano al dominio
ufficiale `https://amiciperlavitabrescia.it/` tramite Cloudflare Bulk Redirects (301).
Elenco: `amici_pages_to_official`. Regola: `A.mici: da Pages al sito ufficiale`.
Sono conservati percorsi e query string. La regola è a livello account, fuori dal codice.
Non eliminare il progetto Pages: serve anche il dominio ufficiale.
