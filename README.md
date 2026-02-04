# Drivers App - F1 🏎️

Aplicación móvil desarrollada con **Flutter** que muestra información en tiempo real de los pilotos de Fórmula 1 utilizando la API pública de **OpenF1**.

## 🚀 Funcionalidades
- **Visualización dinámica**: Carrusel de pilotos destacados (Swiper) y lista completa de la parrilla.
- **Gestión de estado**: Uso de `Provider` para manejar los datos de la API de forma global.
- **Detalles técnicos**: 
  - Colores dinámicos según la escudería del piloto.
  - Lógica para encontrar automáticamente al compañero de equipo.
  - Manejo de errores en imágenes con sistema de respaldo (fallback).

## 🛠️ Tecnologías utilizadas
- Flutter & Dart
- Provider (Gestión de estado)
- HTTP (Peticiones a la API)
- Card Swiper (Interfaz visual)