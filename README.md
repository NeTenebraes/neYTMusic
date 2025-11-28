# neYTMusic: Gestor de Música para Redes Limitadas
[![Debian](https://img.shields.io/badge/Supports-Debian-blue?logo=debian)](https://www.debian.org)
[![Arch Linux](https://img.shields.io/badge/Supports-Arch%20Linux-brightgreen?logo=arch-linux)](https://archlinux.org)
[![Fedora](https://img.shields.io/badge/Supports-Fedora-blueviolet?logo=fedora)](https://getfedora.org)
[![License: GPL](https://img.shields.io/badge/License-GPL-green.svg)](LICENSE)
[![Ko-fi](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Ko--fi-red?logo=kofi)](https://ko-fi.com/netenebrae)

neYTMusic es un *script* diseñado para descargar y reproducir música desde **listas de reproducción de YouTube Music**, utilizando las herramientas esenciales `yt-dlp` y `mpv`. Su propósito principal es servir a usuarios en **entornos de ancho de banda limitado** (como *hotspot* o *tethering*), optimizando el consumo de datos al máximo. Automatiza de forma inteligente la descarga, organización y reproducción de música directamente desde la terminal de Linux.

**Integración Recomendada:** Este *script* funciona de manera óptima en conjunto con herramientas de gestión de red como **[tetherfi](https://github.com/pyamsoft/tetherfi)**

## Tabla de Contenidos
- [Uso Legal y Responsabilidad](#uso-legal-y-responsabilidad)
- [Características Clave](#características-clave)
- [Requisitos del Sistema (Dependencias)](#requisitos-del-sistema-dependencias)
- [Instalación](#instalación)
- [Uso](#uso)
- [Contribuciones y Apoyo](#contribuciones-y-apoyo)


## Uso Legal y Responsabilidad:

neYTMusic no está asociado, respaldado ni afiliado de ninguna forma con Google, YouTube o YouTube Music. El proyecto es independiente y de código abierto, desarrollado para facilitar la descarga de contenido que el usuario pueda reproducir legalmente.

Esta herramienta está diseñada exclusivamente para descarga y reproducción de contenido bajo licencias libres de derechos o condiciones legales que permitan su uso. El usuario es responsable de asegurar que el contenido descargado cumpla con las leyes de derechos de autor y los términos de servicio aplicables.

El autor no asume ninguna responsabilidad por el uso incorrecto o ilegal del software ni por infracciones a derechos de autor derivadas del uso del mismo. Para mayor claridad, el software debe usarse únicamente con:

- Música de Dominio Público: Contenido cuyos derechos son de dominio público.
- Música con Licencia de Libre Uso: Canciones o listas de reproducción de artistas que han liberado su música bajo licencias como Creative Commons (CC) que permiten la descarga.
- Tus Propias Canciones: Si subiste tus propias canciones a YouTube Music, tienes el derecho de hacer copias de ellas.

<img width="1914" height="1049" alt="image" src="https://github.com/user-attachments/assets/4c224aaa-6cd4-4305-8ffd-19e8b0108c3b" />

> Foto real del proyecto.

## Características Clave

### Optimización y Ahorro de Datos
* **Descargas Inteligentes:** Solo procesa canciones **nuevas** de la lista de reproducción, **omitiendo las ya existentes** para maximizar el ahorro de tiempo y ancho de banda.
* **Conversión a MP3:** **Conversión automática a MP3** para una **optimización de almacenamiento** superior y máxima compatibilidad con otros reproductores.
* **Flexibilidad de Red:** Soporte para **conexiones *proxy* dinámicas**, ofreciendo mayor control en entornos de red restringidos.

### Experiencia y Gestión
* **Reproducción Minimalista (mpv):** Reproduce tu música en **modo aleatorio** sin mostrar la consola, asegurando una **experiencia libre de distracciones** con comandos de terminal simples.
* **Gestión de Playlists Persistente:** Soporte para **guardar y reutilizar URLs de *playlists***, facilitando la actualización rápida de tu biblioteca.
* **Organización Automática:** Los archivos se guardan consistentemente en el directorio `~/Music/YTMusic` para una **gestión de biblioteca simple y clara**.

### Mantenimiento
* **Actualización Automática:** El *script* puede **auto-actualizarse** para asegurar que siempre usas la versión más reciente con las últimas mejoras.

## Requisitos del Sistema (Dependencias)

Una característica clave de neYTMusic es que el *script* incluye lógica para **detectar tu sistema operativo Linux** e **instalar automáticamente** las dependencias necesarias utilizando el gestor de paquetes adecuado (`apt`, `dnf` o `pacman`).

Estas son las herramientas esenciales que el instalador buscará, verificará y, si es necesario, solicitará instalar (requiriendo permisos de administrador o `sudo`):

* **`yt-dlp`**: La herramienta principal para la descarga eficiente de contenido de YouTube Music.
* **`mpv`**: El reproductor multimedia utilizado para la reproducción sin consola.
* **`ffmpeg`**: Necesario para la conversión automática de audio al formato **MP3** y la incrustación de metadatos.
* **`curl`** o **`wget`**: Esenciales para la ejecución del instalador y para la función de auto-actualización del *script*.

## Instalación

La instalación coloca el *script* `neYTMusic` en `~/.local/bin`, permitiendo su ejecución desde cualquier terminal. **El instalador se encargará de buscar e instalar las dependencias faltantes en tu sistema.**

### Opción 1:
Ejecuta el one liner:

```
curl -fsSL https://raw.githubusercontent.com/NeTenebraes/neYTMusic-Downloader/main/install.sh | bash
```

### Opción 2: Instalación Manual
1. Descarga el instalador desde [install.sh](https://github.com/NeTenebraes/neYTMusic-Downloader/blob/main/install.sh)
2. Ejecuta `./install.sh.`

## Uso
1. Ejecuta `neYTMusic` desde la terminal.
2. Ingresa la URL de una playlist de YouTube Music cuando se te solicite (se guarda automáticamente para futuros usos).
3. Decide si quieres usar un proxy (opcional).
4. Las canciones se descargarán y organizarán en `~/Music/YTMusic`. El sistema de Descargas Inteligentes evita repetir descargas de canciones ya existentes.
5. Al finalizar, la reproducción en modo aleatorio arrancará automáticamente con `mpv` en segundo plano sin mostrar consola.
6. Controla o detén la reproducción usando los comandos habituales de `mpv`.

**Aviso Importante:** El *script* está diseñado exclusivamente para procesar URLs de **YouTube Music**. No funcionará con URLs de videos o listas de reproducción estándar de **YouTube**.

## Contribuciones y Apoyo

Mejoras, nuevas ideas y reportes de *bugs* son siempre bienvenidos. Tu ayuda es crucial para mantener y este proyecto.

* Puedes **abrir un *Issue*** en el repositorio para reportar problemas o proponer nuevas funcionalidades.
* Puedes **enviar un *Pull Request*** con tu código si deseas implementar una mejora directamente.

---
