#lang racket

(provide add-two-lists)

(define (add-two-lists lst1 lst2)
  (if(empty? lst1)
     lst2
     (if(empty? lst2)
      lst1
      (cons (+ (car lst1) (car lst2)) (add-two-lists (cdr lst1) (cdr lst2)))
     )
  )
)


(add-two-lists '(1 2 3) '(3 2 1))