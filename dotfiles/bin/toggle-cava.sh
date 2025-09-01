#!/bin/bash

# Define el nombre de la clase de la ventana de Alacritty para el visualizador
CAVA_TERM_CLASS="cava-visualizer"

# Busca si ya hay un proceso de cava o una ventana de Alacritty con esa clase
if pgrep cava > /dev/null && hyprctl clients -j | jq -e '.[] | select(.class == '"$CAVA_TERM_CLASS"')' > /dev/null; then
    # Si cava está corriendo y la ventana existe, la cierra
    hyprctl dispatch killactive
else
    # Si no, inicia cava en una nueva terminal con una clase específica
    alacritty --class "$CAVA_TERM_CLASS" -e cava
fi
