package config

import (
	"encoding/json"
	"log"
	"os"
	"path/filepath"
)

type Config struct {
	DatabaseURL      string
	ExternalServices ExternalServicesConfig
}

type ExternalServicesConfig struct {
	CreditValidation ServiceConfig `json:"credit_validation"`
}

type ServiceConfig struct {
	BaseURL  string `json:"base_url"`
	Username string `json:"username"`
	Password string `json:"password"`
}

type AppSettings struct {
	ExternalServices ExternalServicesConfig `json:"external_services"`
}

func LoadConfig() Config {
	dbURL := os.Getenv("DATABASE_URL")
	if dbURL == "" {
		dbURL = "postgres://postgres:root@localhost:5433/opengine?sslmode=disable"
	}

	var extServices ExternalServicesConfig

	// Localiza el appsetting.json de forma dinamica
	jsonPath := os.Getenv("APP_SETTINGS_PATH")
	if jsonPath == "" {
		jsonPath = "appsetting.json"
	}

	if _, err := os.Stat(jsonPath); os.IsNotExist(err) {
		fallbackPath := filepath.Join("..", "appsetting.json")
		if _, errFallback := os.Stat(fallbackPath); errFallback == nil {
			jsonPath = fallbackPath
		}
	}
	log.Printf("Buscando la configuración inicial en: %s", jsonPath)

	// =========================================================================
	// Abrir y decodificar el appsetting
	// =========================================================================
	file, err := os.Open(jsonPath)
	if err != nil {
		log.Println("[CRITICO] No se pudo aperturar la configuracion inicial: ", jsonPath, err)
	} else {
		defer file.Close()

		var settings AppSettings
		decoder := json.NewDecoder(file)
		if err := decoder.Decode(&settings); err != nil {
			log.Printf("[ERROR] Error al decodificar el JSON de %s: %v", jsonPath, err)
		} else {
			extServices = settings.ExternalServices
			log.Printf("Configuracion cargada con éxito. URL Base Detectada: %s", extServices.CreditValidation.BaseURL)
		}
	}

	return Config{
		DatabaseURL:      dbURL,
		ExternalServices: extServices,
	}
}
