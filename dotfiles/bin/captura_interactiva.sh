#!/bin/bash

# Script para capturar una región y elegir dónde guardar la imagen

FILE=$(zenity --file-selection --save --confirm-overwrite --title="Guardar captura como..." --filename="$HOME/captura.png")

if [ -n "$FILE" ]; then
    grim -g "$(slurp)" "$FILE"
fi
