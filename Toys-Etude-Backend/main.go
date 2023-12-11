package main

import (
    "encoding/json"
	"errors"
    "net/http"
    crand "crypto/rand"
	"github.com/gorilla/mux"
	mrand "math/rand"
	// "time"
)

type RandomStringData struct {
	Text string `json:"string"`
}

type RandomStringResponse struct {
	Data []RandomStringData `json:"data"`
}

var data = [] RandomStringData{}

func main() {
    r := mux.NewRouter()
    r.HandleFunc("/v1/random", GenerateRandomData).Methods("GET")

	n := 100000
	for i := 0; i < n; i++ {
		elem, _ := MakeRandomStr(10)
		data = append(data, RandomStringData{
			Text: elem,
		})
	}

    http.Handle("/", r)
    http.ListenAndServe(":8000", nil)
}

func GenerateRandomData(w http.ResponseWriter, r *http.Request) {
	n := mrand.Intn(3)

	// time.Sleep(200 * time.Millisecond)
	response := RandomStringResponse {
		Data: data[n:],
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(response)
}

func MakeRandomStr(digit uint32) (string, error) {
    const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    b := make([]byte, digit)
    if _, err := crand.Read(b); err != nil {
        return "", errors.New("unexpected error...")
    }

    var result string
    for _, v := range b {
        result += string(letters[int(v)%len(letters)])
    }
    return result, nil
}