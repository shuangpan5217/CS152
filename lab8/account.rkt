#lang racket

(require racket/contract)

(struct account (balance))

(provide new-account balance withdraw deposit account)

(define (positive? amt)
  (if (> amt 0) #t #f))

(define (able-to-withdraw? bal)
  (lambda (amt)
    (if (number? amt)
        (if (<= amt 0)
             #f
             (if (> amt bal)
                 #f
                 #t))
        #f)))

;; A new, empty account
(define new-account (account 0))

;; Get the current balance
(define/contract (balance acc)
  (-> account? number?)
  (account-balance acc))

;; Withdraw funds from an account
(define/contract (withdraw acc amt)
  (->i ([the-account account?]
        [the-amount (the-account) (able-to-withdraw? (balance the-account))])
       [return-account account?])
  (account (- (account-balance acc) amt)))

;; Add funds to an account
(define/contract (deposit acc amt)
  (-> account? (and/c number? positive?) account?)
  (account (+ (account-balance acc) amt)))
