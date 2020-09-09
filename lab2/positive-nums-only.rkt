#lang racket

(provide positive-nums-only)

(define (positive-nums-only-helper lst result)
  (cond [(empty? lst) result]
        [(> (car lst) 0) (positive-nums-only-helper (cdr lst) (append result (list (car lst))))]
        [else (positive-nums-only-helper (cdr lst) (append '() result))])
)

(define (positive-nums-only lst)
  (positive-nums-only-helper lst '())
)
