# P1.2 — Prototipo de UI para app del clima

## Alumno

**Nombre:** Jared Ariel González González  
**Práctica:** P1.2 — Prototipo de UI para app del clima — teléfono  
**Unidad:** Unidad 1  
**Herramienta:** Figma  

## Link del prototipo en Figma

[Ver prototipo en Figma](https://www.figma.com/design/y5Q0pF2LiLryUQ9KK5MUG9/Untitled?node-id=0-1&t=JFrbYQS755rYryUD-1)

## Descripción

Esta práctica consiste en el diseño de un prototipo de interfaz móvil para una aplicación del clima.  
El prototipo fue realizado en Figma y contempla una experiencia responsive para teléfono inteligente, considerando orientación vertical y horizontal, componentes reutilizables, navegación entre pantallas y anotaciones técnicas de diseño.

## Pantallas desarrolladas

El prototipo incluye las siguientes pantallas:

1. **Dashboard principal**
   - Ciudad actual
   - Temperatura principal
   - Condición climática
   - Ícono del clima
   - Pronóstico de los próximos 3 días

2. **Detalle de ciudad**
   - Humedad
   - Viento
   - Presión atmosférica
   - Sensación térmica
   - Gráfico simple de temperatura por hora

3. **Configuración**
   - Cambio de ciudad
   - Selección de unidad de temperatura: °C / °F
   - Preferencias de notificaciones

4. **Dashboard en orientación landscape**
   - Adaptación horizontal del dashboard principal
   - Distribución responsive sin cortar elementos

## Navegación del prototipo

Se configuró navegación entre las pantallas principales usando **Prototype Mode** en Figma:

- Pantalla 1 → Pantalla 2
- Pantalla 2 → Pantalla 3
- Pantalla 3 → Pantalla 1

La interacción utilizada fue:

- **Trigger:** On tap
- **Action:** Navigate to
- **Animation:** Move in

## Componentes reutilizables

Se crearon componentes reutilizables en Figma para mantener consistencia visual:

- **Forecast Card**
- **Weather Icon**
- **Bottom Navigation**

## Anotaciones técnicas

El diseño incluye anotaciones técnicas visibles relacionadas con densidad, accesibilidad y tamaños:

- Tamaños de fuente en **sp**
- Espaciados en **dp**
- Elementos tocables con tamaño mínimo de **48dp**
- Contraste mínimo recomendado **WCAG AA 4.5:1**

## Criterio de privacidad

En el dashboard se muestra únicamente la ciudad del usuario.  
No se muestran coordenadas exactas ni datos de ubicación precisa, con el objetivo de proteger la privacidad del usuario.

## Evidencias

En esta carpeta se incluyen capturas de pantalla como respaldo del diseño completo y de las pantallas principales del prototipo.


## Conclusión

El prototipo cumple con los requisitos solicitados para la práctica P1.2, integrando pantallas móviles, versión landscape, navegación entre pantallas, componentes reutilizables, anotaciones técnicas y consideraciones básicas de accesibilidad y privacidad.

Este readme a sido realizado con la ayuda de IA