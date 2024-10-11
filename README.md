# pokemon_ui

Parte UI-Frontend de proyecto pokemon hecho en Flutter.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### Proyecto Pokemon_ui_frontend

## Clonar el Repositorio

Para clonar el repositorio en tu máquina local, sigue estos pasos:

1. **Abre la Terminal o CMD**.
2. **Ejecuta el siguiente comando** para clonar el repositorio:
   git clone https://github.com/tu_usuario/pokemon-api-nodejs.git
3. cd pokemon-ui_frontend
4. git checkout develop

Con esto, ya puedes ver el código y realizar cambios si así lo requiere.

## Estructura de Ramas

Este repositorio sigue la estrategia de **Git Flow**, donde las funcionalidades se desarrollan en ramas separadas y se integran a la rama `develop`. Esto es una buena práctica por varias razones:

1. **Seguridad**: Mantener la rama `main` limpia y libre de errores potenciales. La rama `develop` actúa como un entorno de pruebas, permitiendo detectar y corregir errores antes de que el código se fusione a `main`.

2. **Organización**: Facilita la gestión de diferentes versiones y características del proyecto. Cada nueva funcionalidad se desarrolla en su propia rama y se fusiona a `develop` una vez completada.

3. **Colaboración**: Permite que múltiples desarrolladores trabajen en diferentes características simultáneamente sin interferir con el trabajo de los demás. 

4. **Despliegue**: Se puede configurar un proceso de integración continua (CI) para automatizar pruebas en la rama `develop` antes de realizar el despliegue en `main`.

## Características

- **Lista Paginada de Pokémon**: Muestra Pokémon desde la ID 1 hasta la 150, permitiendo la navegación a través de múltiples páginas.
- **Buscador de Pokémon**: Filtra Pokémon por nombre y tipo (agua, fuego, tierra, etc.).
- **Captura de Pokémon**: Al hacer clic en un Pokémon, se agrega a la lista de Pokémon capturados.
- **Distinción Visual**: Los Pokémon capturados se destacan con un fondo verde claro en la lista.
- **Gestión de Capturas**: Permite capturar hasta 6 Pokémon. Si se intenta capturar más, se eliminará el Pokémon más antiguo de la lista.
- **Interfaz Amigable**: Diseño moderno y fácil de usar que mejora la experiencia del usuario.

## Colores y Fuentes

- **Colores**:
  - **Primario**: `#800080` (Morado)
  - **Fondo de Pokémon Capturados**: `rgba(0, 255, 0, 0.3)` (Verde claro)

- **Fuente**:
  - Se utiliza la fuente **Poppins** para todos los textos, lo que proporciona una apariencia moderna y legible. Para esto se importo una librería de google fonts para mayor facilidad.

## Requisitos

- Flutter (versión 2.0 o superior)
- Dart (versión 2.12 o superior)

## Instalación

1. Clona el repositorio en tu máquina local: git clone <URL de este repo>
2. cd pokemon_ui
3. flutter pub get - para instalar las dependencias
4. flutter run para correr el proyecto

Vale aclarar que en este caso, la UI se hizo a modo Web asi que se podrá probar localmente con diseño a pantalla completa estilo página web.
