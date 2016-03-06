;; form with lambda
(lambda (a b c)
  (* (+ a b c) 3))
;; => #<procedure:2:0>

;; call lambda to use
((lambda (a b c)
  (* (+ a b c) 3)) 8 9 10)
;; => 81

;; define procedure - with lambda
(define sumX3
  (lambda (a b c)
    (* (+ a b c) 3)))
;; > (sumX3 15 6 9)
;; => 90

;; define procedure - without lambda
(define (sumX3 a b c)
  (* (+ a b c) 3))
;; > (sumX3 15 6 9)
;; => 90


