
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


```
[Postman / Cliente] ──> [Tu API (Gin)]
                             │
                             ├──> 1. Valida la data recibida
                             ├──> 2. Construye y envía POST al Servicio Externo
                             │         │
                             │         └─ Se recibe Status 200 OK?
                             │               │
                             │               ├──> SÍ: Inyecta en PostgreSQL ──> Retorna 201/200 al Cliente
                             │               └──> NO: Cancela operación    ──> Retorna Error al Cliente

```