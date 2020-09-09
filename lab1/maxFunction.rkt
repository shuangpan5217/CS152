#lang racket
(provide max-num)
(define (max-num lst)
  (if(= 0 (length lst))
     (error "An empty list.")
     (if(= 1 (length lst))
         (car lst)
         (let([max (car lst)]
               [rest-max (max-num (cdr lst))])
              (if (> max rest-max)
                  max
                  rest-max))
         )
     )
  )

;;store the value in the varibale then compare

(max-num '(9 0 42 1 6)) ;; evaluates to 42
(max-num '(-2 -8 -865)) ;; evaluates to -2