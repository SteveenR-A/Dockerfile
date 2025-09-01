#!/bin/bash
# Animación simple si hay audio reproduciéndose
if playerctl status 2>/dev/null | grep -q Playing; then
  echo '🎵 ░▒▓█'
else
  echo ''
fi
