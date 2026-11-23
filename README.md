# Yazio per Claude, nel cloud

Fa girare il server non ufficiale [yazio-mcp-server](https://github.com/yazio-community/yazio-mcp-server) su Railway, con davanti un proxy che:
- accetta solo richieste su un indirizzo segreto;
- aggiunge da solo le credenziali Yazio, così claude.ai può collegarsi senza intestazioni speciali.

## 1. Crea il servizio su Railway
1. Vai su railway.com e accedi con GitHub.
2. New Project → Deploy from GitHub repo → scegli questo repository.
3. Nella scheda **Variables** aggiungi:
   - `YAZIO_USERNAME` = la tua email Yazio
   - `YAZIO_PASSWORD` = la tua password Yazio
   - `SECRET_PATH` = una stringa casuale lunga (almeno 32 caratteri, solo lettere e numeri). Su Railway puoi scrivere `${{secret(40, "abcdefghijklmnopqrstuvwxyz0123456789")}}` e la genera lui.
4. Settings → Networking → **Generate Domain**. Otterrai un indirizzo come `qualcosa.up.railway.app`.

## 2. Aggiungi il connettore su Claude
1. Su claude.ai (dal browser): Impostazioni → Connettori → Aggiungi connettore personalizzato.
2. URL: `https://qualcosa.up.railway.app/<SECRET_PATH>/mcp`
3. Lascia vuoti i campi OAuth e salva.

Da lì il connettore funziona anche nell'app del telefono.

## Sicurezza
- Chiunque conosca l'URL completo può leggere e scrivere nel tuo diario Yazio: trattalo come una password e non condividerlo.
- Se pensi che sia trapelato, cambia `SECRET_PATH` su Railway e aggiorna l'URL del connettore.
- Il server usa un'API non ufficiale di Yazio e può smettere di funzionare in qualsiasi momento.
