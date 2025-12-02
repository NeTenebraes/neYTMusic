UPDATE_CHECK() {

  # Verifica conectividad
  if ! ping -c 1 github.com &>/dev/null; then
    echo "No hay conexión para actualizar."
    return
  fi

  # Variables con URLs
  REPO_SCRIPT="https://raw.githubusercontent.com/NeTenebraes/neYTMusic/main/neYTMusic.sh"
  CHANGELOG_URL="https://raw.githubusercontent.com/NeTenebraes/neYTMusic/main/CHANGELOG.md"
  CONFIGDIR="$HOME/.config/neYTMusic"
  MODULES_DIR="$CONFIGDIR/Modules"
  BASE_MODULES_URL="https://raw.githubusercontent.com/NeTenebraes/neYTMusic/main/Modules"

  # Descargar script remoto
  local remote_content
  if command -v curl &>/dev/null; then
    remote_content=$(curl -fsSL "$REPO_SCRIPT")
  else
    remote_content=$(wget -qO- "$REPO_SCRIPT")
  fi
  [[ -z "$remote_content" ]] && return

  # Calcular hashes para comparar
  local current_hash
  current_hash=$(sha256sum "$0" | awk '{print $1}')
  local remote_hash
  remote_hash=$(echo "$remote_content" | sha256sum | awk '{print $1}')

  if [[ "$current_hash" != "$remote_hash" ]]; then
    # Extraer versión remota
    local v_remote
    v_remote=$(echo "$remote_content" | grep "^VERSION_LOCAL=" | head -1 | cut -d'"' -f2)

    echo -e "\n¡Cambios Detectados en script principal!"
    echo " Versión del repo: $v_remote"
    echo -e "\nCHANGELOG:"
    if command -v curl &>/dev/null; then
      curl -fsSL "$CHANGELOG_URL" | grep -vE '^# ' | sed 's/^## //' | head -20
    else
      wget -qO- "$CHANGELOG_URL" | grep -vE '^# ' | sed 's/^## //' | head -20
    fi
    echo -e "\n"

    # Preguntar solo cuando hay cambio
    read -e -p "Sincronizar última versión del script principal? [Y/n]: " user_update
    if [[ "$user_update" =~ ^[Yy]$ || -z "$user_update" ]]; then
      echo "$remote_content" > "$0"
      chmod +x "$0"
      echo "¡Script principal sincronizado!"
      exit 0
    else
      echo "Omitiendo sincronización..."
    fi

  else
    # Sin cambios
    echo "El script ya está en la última versión."
  fi

  # Actualizar módulos si existen
  if [[ -d "$MODULES_DIR" ]]; then
    echo -e "\nVerificando actualización de módulos en $MODULES_DIR..."
    for mod_file in "$MODULES_DIR"/*.sh; do
      local filename
      filename=$(basename "$mod_file")
      echo "Verificando módulo: $filename"
      local remote_mod_url="$BASE_MODULES_URL/$filename"
      local remote_mod_content

      if command -v curl &>/dev/null; then
        remote_mod_content=$(curl -fsSL "$remote_mod_url")
      else
        remote_mod_content=$(wget -qO- "$remote_mod_url")
      fi

      [[ -z "$remote_mod_content" ]] && { echo "No se pudo descargar $filename"; continue; }

      local local_hash
      local_hash=$(sha256sum "$mod_file" | awk '{print $1}')
      local remote_hash_mod
      remote_hash_mod=$(echo "$remote_mod_content" | sha256sum | awk '{print $1}')

      if [[ "$local_hash" != "$remote_hash_mod" ]]; then
        echo "Actualizando $filename ..."
        echo "$remote_mod_content" > "$mod_file"
        chmod +x "$mod_file"
        echo "$filename actualizado."
      else
        echo "$filename está actualizado."
      fi
    done
  fi

  echo -e "\nProceso de actualización completado.\n"
}
