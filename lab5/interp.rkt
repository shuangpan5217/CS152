#lang racket

;; Expressions in the language
(struct b-val (val))
(struct b-if (c thn els))
(struct b-succ (e))
(struct b-pred (e))

;; Main evaluate method
(define (evaluate prog)
  (match prog
    [(struct b-val (v)) v]
    [(struct b-if (c thn els))
     (if (evaluate c)
         (evaluate thn)
         (evaluate els))]
    [(struct b-succ (e)) (+ (evaluate e) 1)]
    [(struct b-pred (e)) (- (evaluate e) 1)]
    [_ (error "Unrecognized expression")]))

(evaluate (b-val #t))
(evaluate (b-val #f))
(evaluate (b-if (b-val #t)
                (b-if (b-val #f) (b-val #t) (b-val #f))
                (b-val #f)))
(evaluate (b-succ (b-val 1)))
(evaluate (b-succ (b-succ (b-val 7))))
(evaluate (b-succ (b-pred (b-val 7))))
(evaluate (b-pred (b-pred (b-val 7))))
(evaluate (b-succ (b-if (b-val #t) (b-val 42) (b-val 0))))
(evaluate (b-if (b-val #t) (b-val 42) (b-val 0)))


;; Consider the following sample programs for extending the interpreter
; succ 1  =>  returns 2
; succ (succ 7) => returns 9
; pred 5 => returns 4
; succ (if true then 42 else 0) => 43
