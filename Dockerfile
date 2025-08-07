# Dockerfile für Webmin mit Bind9-Unterstützung
FROM ubuntu:22.04

# Vermeide interaktive Prompts
ENV DEBIAN_FRONTEND=noninteractive

# 🧰 Grundpakete für Repository-Verwaltung und Webmin-Key
RUN apt-get update && \
    apt-get install -y curl gnupg2 apt-transport-https wget software-properties-common

# 🔐 Webmin GPG-Key und Repository hinzufügen
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL http://www.webmin.com/jcameron-key.asc -o /etc/apt/keyrings/webmin.asc && \
    gpg --dearmor -o /etc/apt/keyrings/webmin.gpg /etc/apt/keyrings/webmin.asc && \
    echo "deb [signed-by=/etc/apt/keyrings/webmin.gpg] http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list

# 🚀 Webmin installieren (alleinstehend, wegen Timing-Problemen)
RUN apt-get update && \
    apt-get install -y webmin

# 🛰️ Netzwerktools und Bind9 separat installieren
RUN apt-get update && \
    apt-get install -y iproute2 bind9 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 📝 Entrypoint-Skript einbinden
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 🔁 Startkommando
ENTRYPOINT ["/entrypoint.sh"]
