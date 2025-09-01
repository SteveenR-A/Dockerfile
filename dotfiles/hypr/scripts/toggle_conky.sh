#!/bin/bash

# Script para alternar (abrir/cerrar) Conky

# Usamos una expresión regular para encontrar el proceso de Conky específico
if pgrep -f "conky.*\.conkyrc" > /dev/null; then
    # Si está corriendo, lo cierra
    pkill -f "conky.*\.conkyrc"
else
    # Si no está corriendo, lo inicia en segundo plano
    conky -c ~/.conkyrc &
fi