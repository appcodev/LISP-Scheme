;; Apriori Algorithm
;; Demo case, Market Basket Analysis
;; use to make association rules of the Market Basket

;; example data
(define data '((a d)
               (a b c d)
               (a c d)
               (b c d)))

;; define all goods that appear in data
(define goods '(a b c d))

;; define minimum support
(define min-support 0.4)
;; define minimum confident
(define min-confident 0.75)

