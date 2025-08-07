# 🐳 docker-webmin-bind9

Ein minimalistisches Docker-Image auf Basis von Ubuntu 22.04, das **Webmin** und **Bind9** enthält. Ideal zur Verwaltung eines lokalen Bind9-DNS-Servers über ein Webinterface.

## 🔧 Enthaltene Komponenten

- **Webmin** – Web-basiertes Systemmanagement (Port `10000`)
- **Bind9** – DNS-Server (kann via Webmin konfiguriert werden)
- **iproute2** – für grundlegende Netzwerkanzeige im Container
- **entrypoint.sh** – Startscript mit Passwort-Initialisierung und Logging

## 🚀 Start mit Docker Compose

```yaml
version: '3.8'

services:
  webmin-bind9:
    image: capo42/webmin-bind9:1.0
    container_name: webmin-bind9
    ports:
      - "10000:10000"   # Webmin UI
    volumes:
      - webmin_data:/etc/webmin
      - bind_data:/etc/bind
    restart: unless-stopped

volumes:
  webmin_data:
  bind_data:
```

## 🛡️ Login-Daten

Der Benutzername ist `root`. Das Passwort ist standardmässig `rootpass` und wird beim ersten Start durch das Entrypoint-Skript gesetzt:

```bash
/usr/share/webmin/changepass.pl /etc/webmin root rootpass
```

## 📁 Relevante Verzeichnisse

- `/etc/webmin` – Webmin-Konfiguration
- `/etc/bind` – DNS-Zonen und Konfigurationen

## ❗ Hinweise

- Dieses Image ist **nicht für öffentlich zugängliche Installationen** gedacht.
- Für den internen Einsatz im Heimnetz ist es geeignet.
- Es wird bewusst kein Webmin-Theme oder zusätzliche Pakete mitgeliefert – **Konzentration auf das Notwendigste.**

---

Made with ❤️ by [capo42](https://github.com/capo42)
