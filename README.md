
# Estructura del motor

```
### opengine

|---cmd/
    |---api/
       |---main.go          # Punto de entrada de la aplicación
|---internal/
    |---domain/              # Modelos y entidades de datos (sin dependencias)
    |---repository/          # BD
    |---usecase/             # Lógica de negocio
    |---delivery/            # Controladores HTTP y rutas
--- pkg/                     # Codigo utilitario reutilizable
```