package main

import (
	"fmt"
	"log"
	"net/http"
)

const version = "1.0.0"

func main() {
	const port = 8080
	log.Printf("Listening on 0.0.0.0:%d...\n", port)
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Version %s\n", version)
	})
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), nil))
}
