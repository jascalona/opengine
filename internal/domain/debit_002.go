package domain

type Account struct {
	BankCode string `json:"bank_code"`
	Type     string `json:"type"`
	Number   string `json:"number"`
}

type Amount struct {
	Amt        float64 `json:"amt"`
	Currency   string  `json:"currency"`
	UseDayRate bool    `json:"use_day_rate"`
}

