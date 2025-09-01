# Dotfiles Hyprland + Kitty + Waybar

Este repositorio contiene mi configuración personalizada para Hyprland, Kitty, Waybar y varios scripts de fondos de pantalla. El objetivo principal es mantener un respaldo de mi entorno y facilitar futuras modificaciones, así como recibir sugerencias de la comunidad.

## ⚠️ Advertencia

- Esta configuración es completamente personal y ha sido probada únicamente en mi equipo.
- No es una solución "plug-and-play". Requiere conocimientos para modificar archivos de configuración manualmente.
- No me hago responsable si causa problemas, rompe tu instalación o no funciona como esperas.
- El script `install.sh` **no ha sido comprobado** y puede no funcionar correctamente. **No se recomienda su uso directo** sin revisar y adaptar manualmente la configuración a tu sistema.

## ¿Por qué creé este repositorio?

Al buscar configuraciones de Hyprland y Waybar, noté que muchas eran difíciles de modificar o no se adaptaban a mis gustos. Por eso, decidí crear mi propia configuración desde cero, documentando cada ajuste para facilitar futuras modificaciones y compartir ideas con otros usuarios.
## Descripción General

Esta configuración está pensada para un flujo de trabajo ligero, productivo y estéticamente agradable. Utiliza una combinación de herramientas que se integran para ofrecer una experiencia de usuario cohesiva y personalizada. La barra de Waybar se adapta a los colores del fondo de pantalla, al igual que Kitty. Para lograr esto, se utiliza Pywal. También se puede usar la extensión Wal Theme de VS Code para que los colores del editor cambien dinámicamente según el fondo de pantalla. Se recomienda usar fondos de pantalla con colores adecuados para que sean agradables a la vista.
 
## Prerrequisitos (Dependencias)

Antes de instalar estos dotfiles, asegúrate de tener el siguiente software instalado. Puedes usar `yay` o `pacman` para instalarlos.

- **Gestor de ventanas y barra de estado:**
  - `hyprland`: Gestor de ventanas principal.
  - `waybar`: Barra de estado altamente personalizable.
- **Terminal y Shell:**
  - `kitty`: Emulador de terminal rápido y basado en GPU.
  - `zsh`: Shell interactivo (alternativa a bash).
- **Lanzadores y Menús:**
  - `fuzzel`: Lanzador de aplicaciones eficiente para Wayland.
  - `wlogout`: Menú de apagado/reinicio/sesión.
- **Utilidades del Sistema y Personalización:**
  - `swaync`: Demonio de notificaciones.
  - `pywal`: Genera paletas de colores a partir de fondos de pantalla.
  - `swww`: Demonio para gestionar fondos de pantalla.
  - `hypridle`: Demonio para manejar la inactividad (bloqueo de pantalla).
  - `hyprlock`: El bloqueador de pantalla.
  - `htop`: Visor de procesos interactivo.
  - `fastfetch` / `neofetch`: Herramientas para mostrar información del sistema.
  - `cava`: Visualizador de audio para la terminal.
- **Herramientas de Captura y Multimedia:**
  - `grim` y `slurp`: Para capturas de pantalla.
  - `pamixer`: Control de volumen de PulseAudio.
  - `brightnessctl`: Control del brillo de la pantalla.
  - `playerctl`: Control de reproductores multimedia.

## Instalación

1.  **Clona el repositorio:**
  ```bash
  git clone <URL_DEL_REPOSITORIO> ~/dotfiles
  cd ~/dotfiles
  ```

2.  **(Opcional) Dale permisos de ejecución al script:**
  ```bash
  chmod +x install.sh
  ```

3.  **(No recomendado) Ejecuta el script de instalación:**
  ```bash
  ./install.sh
  ```

> ⚠️ **Advertencia:** El script `install.sh` no ha sido comprobado y puede no funcionar correctamente. Se recomienda revisar y adaptar manualmente la configuración antes de usarlo.

El script está pensado para:
- Crear una copia de seguridad de tus configuraciones existentes en `~/.config_backup`.
- Crear los enlaces simbólicos necesarios para que el sistema utilice estos dotfiles.
## Fondos de pantalla dinámicos

Incluye scripts para cambiar el fondo de pantalla de forma automática cada 3 minutos, así como scripts para cambio manual o aleatorio. Recuerda modificar las rutas de los fondos de pantalla en los scripts según tu entorno.


## Atajos de Teclado Principales

Los atajos están definidos en `config/hypr/hyprland.conf`. Aquí hay algunos ejemplos:

- `SUPER + A`: Abrir la terminal (kitty).
- `SUPER + D`: Abrir el lanzador de aplicaciones (fuzzel).
- `SUPER + B`: Cambiar a un fondo de pantalla aleatorio.
- `SUPER + Q`: Cerrar la ventana activa.
- `SUPER + L`: Bloquear la pantalla (hyprlock).

Para ver todos los atajos, revisa el archivo `hyprland.conf`.




## Autor
SteveenR-A

