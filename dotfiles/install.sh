#!/bin/bash

# --- Colores para la salida ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# --- Directorios ---
DOTFILES_DIR=$(pwd)
CONFIG_DIR="$DOTFILES_DIR/config"
BACKUP_DIR=~/.config_backup_$(date +%Y%m%d_%H%M%S)

# --- Lista de dependencias ---
dependencies=(
    "hyprland" "waybar" "kitty" "zsh" "fuzzel" "wlogout"
    "swaync" "wal" "swww" "hypridle" "hyprlock" "htop"
    "fastfetch" "neofetch" "cava" "grim" "slurp" "pamixer"
    "brightnessctl" "playerctl"
)

# --- Función para verificar dependencias ---
check_dependencies() {
    echo -e "${YELLOW}Verificando dependencias...${NC}"
    for cmd in "${dependencies[@]}"; do
        if ! command -v $cmd &> /dev/null; then
            echo -e "  ${YELLOW}ADVERTENCIA: El comando '$cmd' no se encontró. Por favor, instálalo para una funcionalidad completa.${NC}"
        else
            echo -e "  ${GREEN}OK: $cmd encontrado.${NC}"
        fi
    done
    echo ""
}

# --- Función para crear respaldos y enlaces simbólicos ---
create_symlinks() {
    echo -e "${YELLOW}Creando respaldos y enlaces simbólicos...${NC}"
    mkdir -p $BACKUP_DIR

    # Archivos de configuración en .config
    for config in $(ls $CONFIG_DIR); do
        source_path="$CONFIG_DIR/$config"
        target_path=~/.config/$config

        if [ -e "$target_path" ]; then
            echo "  Respaldando $target_path en $BACKUP_DIR"
            mv "$target_path" "$BACKUP_DIR/"
        fi
        
        echo "  Enlazando $source_path a $target_path"
        ln -sf "$source_path" ~/.config/
    done

    # Carpeta de fondos de pantalla
    wallpaper_source="$DOTFILES_DIR/Fondo de pantalla"
    wallpaper_target=~/Imágenes/"Fondo de pantalla"
    if [ -d ~/Imágenes ]; then
        if [ -e "$wallpaper_target" ]; then
            echo "  Respaldando $wallpaper_target en $BACKUP_DIR"
            mv "$wallpaper_target" "$BACKUP_DIR/"
        fi
        echo "  Enlazando $wallpaper_source a ~/Imágenes/"
        ln -sf "$wallpaper_source" ~/Imágenes/
    else
        echo -e "  ${YELLOW}ADVERTENCIA: El directorio '~/Imágenes' no existe. No se creará el enlace para los fondos de pantalla.${NC}"
    fi

    echo ""
}

# --- Script Principal ---
echo -e "${GREEN}=== Iniciando Instalación de Dotfiles ===${NC}"
check_dependencies
create_symlinks
echo -e "${GREEN}=== Instalación Completada ===${NC}"
echo "Por favor, reinicia tu sesión de Hyprland para que todos los cambios surtan efecto."