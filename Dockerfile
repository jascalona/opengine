# ETAPA 1: Construcción (Builder)
FROM golang:1.26-alpine AS builder

WORKDIR /app

# Archivos de dependencias
COPY go.mod go.sum ./
RUN go mod download

# Copiamos todo el código fuente
COPY . .

# SOLUCIÓN: Apuntamos al directorio correcto del main (./cmd) 
RUN CGO_ENABLED=0 GOOS=linux go build -o main ./cmd

# ETAPA 2: Ejecución (Final)
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copiamos el binario desde la raíz de la etapa anterior (/app/main)
COPY --from=builder /app/main .

COPY ./appsetting.json .

EXPOSE 8082

# Ejecutamos el binario directamente desde el directorio actual
CMD ["./main"]
