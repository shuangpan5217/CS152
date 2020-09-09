#lang racket
(provide fizzbuzz)

;; The function counts from 1 to the specified number, printing a string with the result.
;; The rules are:
;;    If a number is divisible by 3 and by 5, instead say "fizzbuzz"
;;    Else if a number is divisible by 3, instead say "fizz"
;;    Else if a number is divisible by 5, instead say "buzz"
;;    Otherwise say the number
;;
(define (fizzbuzz n) 
  (if(> n 0)
     (string-append (fizzbuzz (- n 1)) (cond [(= (remainder n 15) 0) "fizzbuzz "]
                                [(= (remainder n 3) 0) "fizz "]
                                [(= (remainder n 5) 0) "buzz "]
                                [else (string-append (number->string n) " ")]))
     ""
  )
)
