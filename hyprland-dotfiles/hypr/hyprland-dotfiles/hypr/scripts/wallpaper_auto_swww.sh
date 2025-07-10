#!/bin/bash
# Cambia el fondo automáticamente cada 5 minutos (imágenes, animación aleatoria sin repetición, pywal)
WALLPAPER_DIR="/home/androw/Imágenes/Fondo de pantalla"
LAST_WALLPAPER_FILE="/tmp/last_hypr_wallpaper.txt"

# Lista completa de animaciones para más variedad
ANIMACIONES=(simple fade left right top bottom wipe wave grow outer)
ANIM_TRACK_FILE="/tmp/animaciones_wallpaper_auto.txt"
IMG_TRACK_FILE="/tmp/imagenes_wallpaper_auto.txt"

while true; do
    # 1. Gestionar lista de animaciones
    # Si el fichero de seguimiento no existe o está vacío, lo creamos con la lista de animaciones barajada
    if [ ! -s "$ANIM_TRACK_FILE" ]; then
        printf "%s\n" "${ANIMACIONES[@]}" | shuf > "$ANIM_TRACK_FILE"
    fi
    # Leemos la primera animación de la lista y la eliminamos para no repetirla
    ANIM=$(head -n 1 "$ANIM_TRACK_FILE")
    sed -i '1d' "$ANIM_TRACK_FILE"

    # 2. Gestionar lista de imágenes
    # Si el fichero de seguimiento no existe o está vacío, lo creamos con la lista de imágenes barajada
    if [ ! -s "$IMG_TRACK_FILE" ]; then
        find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | shuf > "$IMG_TRACK_FILE"
    fi
    # Leemos la primera imagen de la lista y la eliminamos para no repetirla
    IMG=$(head -n 1 "$IMG_TRACK_FILE")
    sed -i '1d' "$IMG_TRACK_FILE"

    # 3. Aplicar el fondo si se encontró una imagen
    if [ -n "$IMG" ]; then
        # Efecto especial para ciertas animaciones para darles más impacto
        case "$ANIM" in
            wipe|wave)
                # Para wipe y wave, usamos una duración más larga para que se aprecie mejor el efecto
                swww img "$IMG" --resize fit --transition-type "$ANIM" --transition-duration 2 --transition-fps 60 --transition-pos center
                ;;
            *)
                # Animaciones estándar con duración normal
                swww img "$IMG" --resize fit --transition-type "$ANIM" --transition-duration 1.2 --transition-fps 60
                ;;
        esac

        echo "$IMG" > "$LAST_WALLPAPER_FILE"
        # Generar paleta de colores con pywal (sin recargar ni lanzar waybar)
        if command -v wal &>/dev/null; then
            wal -i "$IMG" -q -n
        fi
       
    # Intervalo de cambio reducido a 5 minutos
    sleep 300
done
