#!/bin/bash
check_root() {
    if [[ $EUID -ne 0 ]]; then
        exit 1
    fi
}
install_package() {
    local package_name=$1
    if ! apt install -y "$package_name"; then
        exit 1
    fi
}
check_root
apt update && apt upgrade -y
install_package apache2
install_package mariadb-server
install_package php libapache2-mod-php php-mysql php-cli php-curl php-json php-mbstring php-xml php-zip
a2enmod rewrite
systemctl restart apache2
systemctl status apache2 | grep Active
systemctl status mariadb | grep Active
exit 0
