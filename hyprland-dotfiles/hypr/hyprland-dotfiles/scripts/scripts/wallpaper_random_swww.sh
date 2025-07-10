#!/bin/bash
# Cambia el fondo manualmente (SUPER+B) a uno aleatorio (imagen o video) con animación dinámica y pywal.

# --- Configuración ---
# Directorio de fondos de pantalla
WALLPAPER_DIR="/home/Imágenes/Fondo de pantalla"
LAST_WALLPAPER_FILE="/tmp/last_hypr_wallpaper.txt"
# Animaciones para swww
ANIMACIONES=(simple fade left right top bottom wipe wave grow outer)
ANIM_TRACK_FILE="/tmp/animaciones_wallpaper.txt"
# Fichero para la lista de fondos aleatorios
WALLPAPER_TRACK_FILE="/tmp/wallpapers_random_track.txt"

# --- Funciones ---
# Notificar al usuario
notify() {
    notify-send "Wallpaper Script" "$1" -t 3000
}

# Obtener una animación aleatoria sin repetir hasta agotar la lista
get_random_animation() {
    # Si el fichero de seguimiento no existe o está vacío, lo creamos con la lista de animaciones barajada
    if [ ! -s "$ANIM_TRACK_FILE" ]; then
        printf "%s\n" "${ANIMACIONES[@]}" | shuf > "$ANIM_TRACK_FILE"
    fi

    # Leemos la primera animación de la lista
    local anim
    anim=$(head -n 1 "$ANIM_TRACK_FILE")
    # La eliminamos del fichero para no repetirla en la siguiente ejecución
    sed -i '1d' "$ANIM_TRACK_FILE"
    
    echo "$anim"
}

# --- Lógica Principal ---

# 1. Comprobar si la lista de fondos existe y tiene contenido. Si no, la creamos.
if [ ! -s "$WALLPAPER_TRACK_FILE" ]; then
    # Buscar todos los fondos de pantalla (imágenes y videos), barajarlos y guardarlos
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" -o -iname "*.mp4" -o -iname "*.webm" \) | shuf > "$WALLPAPER_TRACK_FILE"
fi

# 2. Comprobar si se encontraron fondos después de intentar crear la lista
if [ ! -s "$WALLPAPER_TRACK_FILE" ]; then
    notify "No se encontraron fondos en '$WALLPAPER_DIR'."
    # Borramos el fichero de seguimiento si está vacío para que se regenere la próxima vez
    rm -f "$WALLPAPER_TRACK_FILE"
    exit 1
fi

# 3. Seleccionar el siguiente fondo de la lista y eliminarlo para no repetirlo
SELECTED_WALLPAPER=$(head -n 1 "$WALLPAPER_TRACK_FILE")
sed -i '1d' "$WALLPAPER_TRACK_FILE"

# 4. Aplicar el fondo según su tipo (video o imagen)
case "$SELECTED_WALLPAPER" in
    *.mp4|*.webm)
        # Es un video, usar mpvpaper
        pkill mpvpaper 2>/dev/null
        mpvpaper -o "--loop --no-audio" "*" "$SELECTED_WALLPAPER" &
        ;;
    *.jpg|*.jpeg|*.png|*.gif|*.webp)
        # Es una imagen, usar swww con una animación aleatoria
        pkill mpvpaper 2>/dev/null # Detener video si se estaba reproduciendo
        
        ANIM=$(get_random_animation)

        swww img "$SELECTED_WALLPAPER" --resize fit --transition-type "$ANIM" --transition-duration 1.2 --transition-fps 60
        
        # Generar paleta de colores con pywal y recargar waybar
        if command -v wal &>/dev/null; then
            wal -i "$SELECTED_WALLPAPER" -q -n
            pkill -SIGUSR2 waybar 2>/dev/null
        fi
        ;;
esac


