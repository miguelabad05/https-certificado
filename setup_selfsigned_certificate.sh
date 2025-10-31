#!/bin/bash

# Script para crear y configurar un certificado SSL/TLS autofirmado en Apache

# Variables
CERT_DIR="/etc/apache2/ssl"
CERT_KEY="$CERT_DIR/apache-selfsigned.key"
CERT_CRT="$CERT_DIR/apache-selfsigned.crt"
SSL_CONF="/etc/apache2/sites-available/default-ssl.conf"

sudo apt update
sudo apt install -y apache2 openssl

sudo mkdir -p "$CERT_DIR"

sudo openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout "$CERT_KEY" \
  -out "$CERT_CRT" \
  -subj "/C=ES/ST=Valencia/L=Valencia/O=MiEmpresa/CN=localhost"

sudo bash -c "cat > $SSL_CONF" <<EOF
<IfModule mod_ssl.c>
  <VirtualHost _default_:443>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html

    SSLEngine on
    SSLCertificateFile      $CERT_CRT
    SSLCertificateKeyFile   $CERT_KEY

    <FilesMatch "\\.(cgi|shtml|phtml|php)\$">
        SSLOptions +StdEnvVars
    </FilesMatch>

    <Directory /usr/lib/cgi-bin>
        SSLOptions +StdEnvVars
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
  </VirtualHost>
</IfModule>
EOF

sudo a2enmod ssl
sudo a2ensite default-ssl.conf

sudo systemctl restart apache2

https://localhost."
