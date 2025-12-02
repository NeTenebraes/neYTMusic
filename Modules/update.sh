UPDATE_CHECK() {
    # 1. Verificaciones básicas de conectividad
    if ! ping -c 1 github.com &>/dev/null; then return; fi
    
    # 2. Descargar el script remoto
    local remote_content
    if command -v curl &>/dev/null; then
        remote_content=$(curl -fsSL "$REPO_SCRIPT")
    else
        remote_content=$(wget -qO- "$REPO_SCRIPT")
    fi

    if [[ -z "$remote_content" ]]; then return; fi

    # 3. Calcular HASHES
    local current_hash
    current_hash=$(sha256sum "$0" | awk '{print $1}')
    
    local remote_hash
    remote_hash=$(echo "$remote_content" | sha256sum | awk '{print $1}')

    # 4. Comparar
    if [[ "$current_hash" != "$remote_hash" ]]; then
        # Extraer versión remota
        local v_remote=$(echo "$remote_content" | grep "^VERSION_LOCAL=" | head -1 | cut -d'"' -f2)
        
        echo -e "\n¡Cambios Detectados!"
        echo "   Versión del repo: $v_remote"
        #CHANGELOG
            echo -e "\nCHANGELOG:"
    if command -v curl &>/dev/null; then
        curl -fsSL "$CHANGELOG_URL" \
        | grep -vE '^# ' \
        | sed 's/^## //' \
        | head -20
    else
        wget -qO- "$CHANGELOG_URL" \
        | grep -vE '^# ' \
        | sed 's/^## //' \
        | head -20
    fi
        echo -e "\n"
        #Actualización
        read -e -p "Sincronizar última versión del script? [Y/n]: " user_update
        if [[ "$user_update" =~ ^[Yy]$ || -z "$user_update" ]]; then
            echo "$remote_content" > "$0"
            chmod +x "$0"
            echo "¡Sincronizado!"
            exit 0
        else
            echo "Omitiendo sincronización..."
        fi
    fi
}