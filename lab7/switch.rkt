#lang racket

(define-syntax switch
  (syntax-rules ()
    [(switch num (default exp)) exp]
    [(swtich num (val exp) rest ...) (if (eqv? num val) exp (switch num rest ...))]
    ))




(define x 6)
(switch x
    [3 (displayln "x is 3")]
    [4 (displayln "x is 4")]
    [5 (displayln "x is 5")]
    [default (displayln "none of the above")])