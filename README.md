# prueba_task_manager

Este proyecto es una aplicación Flutter para gestionar tareas y mostrar un listado de paises. Está desarrollado con **Clean Architecture**, **MVVM** y **Riverpod**.

---

# Requisitos

- Flutter 3.x o superior
- Dart SDK 3.x
- Android Studio o VS Code (con soporte Flutter)
- Dispositivo físico o emulador configurado

---

# Instalación de dependencias

flutter pub get

---

# Generación de archivos 

flutter pub run build_runner build --delete-conflicting-outputs

---

# Ejecución de la aplicación

- Abre un emulador o conecta un dispositivo físico.
- Verifica que el dispositivo esté conectado:
    - flutter devices
- Ejecuta la app:
    - flutter run

---

# Función de la aplicación

- Vista principal:
    - Muestra el listado de tareas.
    - En la AppBar hay una opción para filtrar tareas: completadas, incompletas o todas.
    - En la AppBar también hay una opción para navegar a la vista de países.
    - Al seleccionar el checkbox de una tarea, se marca como completada o incompleta.
    - Al seleccionar una tarea, se abre la vista para editarla.
    - Al presionar el FloatingActionButton, se abre la vista para crear una nueva tarea.
- Vista de edición y creación:
    - Incluye un campo de texto para ingresar o modificar el título de la tarea.
    - Tiene un switch para marcar la tarea como completada o incompleta.
    - Al presionar el botón, se guarda o actualiza la tarea.
- Vista de países:
    - Muestra un listado de países.

---
