#!/bin/bash

set -e
clear

cat << "EOF"
▐▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▌
▐  ____            _       _     ___           _        _ _            ▌
▐ / ___|  ___ _ __(_)_ __ | |_  |_ _|_ __  ___| |_ __ _| | | ___ _ __  ▌
▐ \___ \ / __| '__| | '_ \| __|  | || '_ \/ __| __/ _` | | |/ _ \ '__| ▌
▐  ___) | (__| |  | | |_) | |_   | || | | \__ \ || (_| | | |  __/ |    ▌
▐ |____/ \___|_|  |_| .__/ \__| |___|_| |_|___/\__\__,_|_|_|\___|_|    ▌
▐                   |_|                                                ▌
▐▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▌
Script by NeTenebrae: https://github.com/NeTenebraes
        Instalador automático: neYTMusic Downloader
EOF
echo ""

DEPENDENCIAS=(yt-dlp mpv curl wget)
FALTAN=()

for dep in "${DEPENDENCIAS[@]}"; do
    if ! command -v "$dep" &>/dev/null; then
        FALTAN+=("$dep")
    fi
done

if [[ ${#FALTAN[@]} -gt 0 ]]; then
    echo "Faltan dependencias: ${FALTAN[*]}"
    echo "Instalando dependencias necesarias..."
    if command -v pacman &>/dev/null; then
        sudo pacman -Sy --noconfirm "${FALTAN[@]}"
    elif command -v apt &>/dev/null; then
        sudo apt update && sudo apt install -y "${FALTAN[@]}"
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y "${FALTAN[@]}"
    else
        echo "No se detectó un gestor de paquetes compatible (pacman, apt, dnf)."
        echo "Instala manualmente: ${FALTAN[*]}"
        exit 1
    fi
else
    echo "Todas las dependencias están instaladas, continuando..."
fi

# Instalar script principal
SCRIPT_URL="https://raw.githubusercontent.com/NeTenebraes/neYTMusic-Downloader/main/neYTMusic.sh"
INSTALL_PATH="$HOME/.local/bin/neYTMusic"

echo ""
echo "Descargando 'neYTMusic.sh'..."
if command -v curl &>/dev/null; then
    curl -fsSL "$SCRIPT_URL" -o "$INSTALL_PATH"
else
    wget -qO "$INSTALL_PATH" "$SCRIPT_URL"
fi
chmod +x "$INSTALL_PATH"

echo "El script principal se ha instalado en ~/.local/bin/ y sobrescribirá versiones previas."

# Verificar PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    echo "PATH actualizado. Reinicia la terminal para activar el comando 'neYTMusic'."
fi

echo ""
echo "¡Instalación completa!"
echo "Ejecuta 'neYTMusic' en tu terminal para iniciar."
