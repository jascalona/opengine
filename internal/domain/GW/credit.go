package gw

import (
	"context"
)

type CreditTransaction struct {
	TraceId                 string        `json:"TraceId" db:"trace_id"`
	TransactionId           string        `json:"TransactionId" db:"transaction_id"`
	UserId                  string        `json:"UserId" db:"user_id"`
	UserReferenceId         string        `json:"UserReferenceId" db:"user_reference_id"`
	UserGroupId             string        `json:"UserGroupId" db:"user_group_id"`
	UserUniqueId            string        `json:"UserUniqueId" db:"user_unique_id"`
	CreationDate            *string       `json:"CreationDate" db:"creation_date"`
	SypagoInitDate          *string       `json:"SypagoInitDate" db:"sypago_init_date"`
	SypagoProcessDate       *string       `json:"SypagoProcessDate" db:"sypago_process_date"`
	Product                 string        `json:"Product" db:"product"`
	SubProduct              string        `json:"SubProduct" db:"sub_product"`
	Amount                  AmountDetails `json:"Amount" db:"amount"`
	ProductSypago           string        `json:"ProductSypago" db:"product_sypago"`
	SubProductSypago        string        `json:"SubProductSypago" db:"sub_product_sypago"`
	ApprovalAgent           string        `json:"ApprovalAgent" db:"approval_agent"`
	SyPagoCreationChannel   string        `json:"SyPagoCreationChannel" db:"sypago_creation_channel"`
	SyPagoAcceptanceChannel string        `json:"SyPagoAcceptanceChannel" db:"sypago_acceptance_channel"`
	IssuingAgent            string        `json:"IssuingAgent" db:"issuing_agent"`
	IssuingUser             UserData      `json:"IssuingUser" db:"issuing_user"`
	ReceivingAgent          string        `json:"ReceivingAgent" db:"receiving_agent"`
	ReceivingUser           UserData      `json:"ReceivingUser" db:"receiving_user"`
	Inseted_at              string        `json:"Inserted_at" db:"inserted_at"`
}

type AmountDetails struct {
	Amt        float64 `json:"Amt"`
	Ccy        string  `json:"Ccy"`
	Commission float64 `json:"Commission"`
}

// Manejamos la data de ambas contrapartes
type UserData struct {
	UserId     string       `json:"UserId"`
	LinkUserId string       `json:"LinkUserId"`
	Account    AccountInfo  `json:"Account"`
	Document   DocumentInfo `json:"Document"`
}

type AccountInfo struct {
	Tp string `json:"Tp"`
	Id string `json:"Id"`
}

type DocumentInfo struct {
	Id      string `json:"Id"`
	Nm      string `json:"Nm,omitempty"`
	SchmeNm string `json:"SchmeNm"`
}

// Repository define el contrato para la persistencia
type Repository interface {
	Save(tx *CreditTransaction) error
	GetByID(id string) (*CreditTransaction, error)
}

type ValidateServiceCredit struct {
	TraceId                 string        `json:"TraceId" binding:"omitempty"`
	TransactionId           string        `json:"TransactionId" binding:"omitempty"`
	UserId                  string        `json:"UserId" binding:"omitempty"`
	UserReferenceId         string        `json:"UserReferenceId" binding:"omitempty"`
	UserGroupId             string        `json:"UserGroupId" binding:"omitempty"`
	UserUniqueId            string        `json:"UserUniqueId" binding:"omitempty"`
	CreationDate            *string       `json:"CreationDate" binding:"omitempty"`
	SypagoInitDate          *string       `json:"SypagoInitDate" binding:"omitempty"`
	SypagoProcessDate       *string       `json:"SypagoProcessDate" binding:"omitempty"` // mapear la fecha una vez que el request contra la api es exitoso
	Product                 string        `json:"Product" binding:"required"`
	SubProduct              string        `json:"SubProduct" binding:"required"`
	Amount                  AmountDetails `json:"Amount" binding:"required"`
	ProductSypago           string        `json:"ProductSypago" binding:"omitempty"`
	SubProductSypago        string        `json:"SubProductSypago" binding:"omitempty"`
	ApprovalAgent           string        `json:"ApprovalAgent" binding:"omitempty"`
	SyPagoCreationChannel   string        `json:"SyPagoCreationChannel" binding:"omitempty"`
	SyPagoAcceptanceChannel string        `json:"SyPagoAcceptanceChannel" binding:"omitempty"`
	IssuingAgent            string        `json:"IssuingAgent" binding:"required,max=4,min=4"`
	IssuingUser             UserData      `json:"IssuingUser" binding:"required"`
	ReceivingAgent          string        `json:"ReceivingAgent" binding:"required,max=4,min=4"`
	ReceivingUser           UserData      `json:"ReceivingUser" binding:"required"`
}

type InterfaceServiceCredit interface {
	ListCredit(ctx context.Context) ([]*CreditTransaction, error)
	InitCredit(ctx context.Context, tx *CreditTransaction) error
}
