package main

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	"opengine.com/m/cmd/config"
	"opengine.com/m/internal/delivery"
	"opengine.com/m/internal/delivery/router"
	"opengine.com/m/internal/repository"
	"opengine.com/m/internal/serv"
)

func main() {
	// Cargar variables de entorno
	if err := godotenv.Load(); err != nil {
		log.Println("Archivo .env no encontrado, usando variables de sistema.")
	}

	// Cargar configuracion e inicializar DB
	cfg := config.LoadConfig()
	dbConn := config.InitDB(cfg.DatabaseURL)
	defer dbConn.Close()

	// =========================================================================
	// INJECCION DE DEPENDENCIAS NEGOCIO (REPO)
	// =========================================================================
	gw_credit_repo := repository.NewRepoInitCreditGW(dbConn)

	// =========================================================================
	// INJECCION DE DEPENDENCIAS AUDITORIA (SERV)
	// =========================================================================
	gw_credit_serv := serv.NewServInitCreditGW(gw_credit_repo)

	// =========================================================================
	// INJECCION DE DEPENDENCIAS (MANEJADOR HTTP)
	// =========================================================================
	gw_credit_handler := delivery.NewHandlerInitCreditGW(gw_credit_serv)

	// =========================================================================
	// INSTANCIACIÓN DE ENRUTADORES MODULARES
	// =========================================================================
	gw_transaction := router.NewRouterGW(
		gw_credit_handler,
	)

	gwRouter := router.MainRouter{
		RouterGW: gw_transaction,
	}

	// =========================================================================
	// INICIALIZACIÓN DE GIN Y RUTAS CENTRALES
	// =========================================================================
	r := gin.Default()

	router.SetupRouter(r, gwRouter)

	// ejecucion del srv
	port := ":8089"
	log.Printf("Servidor corriendo en el puerto: %s", port)
	if err := r.Run(port); err != nil {
		log.Println("Error al iniciar el servidor: ", err)
	}

}
