#lang racket

(provide reverse)

(define (reverse lst)
  (if (= 0 (length lst)) '()
      (append (reverse (cdr lst)) (list (car lst)))
  )
)