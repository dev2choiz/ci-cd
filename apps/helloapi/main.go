package main

import (
	"helloapi/helloworld"
	"fmt"
	"net/http"
)

func main()  {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		s := helloworld.Say()
		_, err := w.Write([]byte(s))
		if err != nil {
			panic(err)
		}
	})

	f := func(w http.ResponseWriter, r *http.Request) {
		_, err := w.Write([]byte("ok"))
		if err != nil {
			panic(err)
		}
	}
	http.HandleFunc("/healthz", f)
	http.HandleFunc("/readiness", f)

	p := 80
	fmt.Printf("helloapi listen port %d\n", p)
	err := http.ListenAndServe(fmt.Sprintf(":%d", p), nil)
	if err != nil {
		panic(err)
	}
}
