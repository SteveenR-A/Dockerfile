#!/bin/bash
# Muestra el nombre de la app activa o el título de la página si es navegador
app=$(hyprctl activewindow -j | jq -r '.class')
title=$(hyprctl activewindow -j | jq -r '.title')
if [[ "$app" =~ "firefox"|"chromium"|"brave" ]]; then
#  echo "🌐 $title"
#else
  echo " $app"
fi
