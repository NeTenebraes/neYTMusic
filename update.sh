#!/bin/bash
# update.sh - lógica modular para actualización

VERSION_LOCAL="1.0.1"
REPO_SCRIPT="https://raw.githubusercontent.com/NeTenebraes/neYTMusic-Downloader/main/neYTMusic.sh"
CHANGELOG_URL="https://raw.githubusercontent.com/NeTenebraes/neYTMusic-Downloader/main/CHANGELOG.md"

UPDATE_CHECK() {
    if ! command -v curl &>/dev/null && ! command -v wget &>/dev/null; then
        echo "curl o wget no encontrados. No se puede comprobar actualizaciones."
        return
    fi
    if ! ping -c 1 github.com &>/dev/null; then
        echo "Sin conexión a internet. Omitiendo comprobación de actualizaciones."
        return
    fi
    if command -v curl &>/dev/null; then
        VERSION_REMOTE=$(curl -fsSL "$REPO_SCRIPT" | grep "^VERSION_LOCAL=" | head -1 | cut -d'"' -f2)
    else
        VERSION_REMOTE=$(wget -qO- "$REPO_SCRIPT" | grep "^VERSION_LOCAL=" | head -1 | cut -d'"' -f2)
    fi
    if [[ "$VERSION_REMOTE" != "$VERSION_LOCAL" && -n "$VERSION_REMOTE" ]]; then
        echo "¡Nueva versión disponible: $VERSION_REMOTE!"
        echo "Cambios recientes:"
        if command -v curl &>/dev/null; then
            curl -fsSL "$CHANGELOG_URL" | head -20
        else
            wget -qO- "$CHANGELOG_URL" | head -20
        fi
        read -e -p "¿Actualizar ahora el script? [Y/n]: " user_update
        if [[ "$user_update" =~ ^[Yy]$ || -z "$user_update" ]]; then
            if command -v curl &>/dev/null; then
                curl -fsSL "$REPO_SCRIPT" -o "$0"
            else
                wget -qO "$0" "$REPO_SCRIPT"
            fi
            chmod +x "$0"
            echo "¡Actualizado! Vuelve a ejecutar el script."
            exit 0
        else
            echo "Continuando con la versión actual ($VERSION_LOCAL)..."
        fi
    else
        echo "Ya tienes la última versión ($VERSION_LOCAL)."
    fi
}
