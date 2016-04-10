;; basic module structure
;; consists of require statement (if need),
;; define function statement
;; and export identifiers
(module my-module mzscheme
  ;; require
  ;; define functions
  (define (power m n)
    (cond ((= n 1) m)
          (else (* m (power m (- n 1))))))
  
  (define (sum m n)
    (+ m n))
  
  (define (sum-power m n)
    (sum (power m n) 
         (power n m)))
  
  ;; export (provide)
  (provide sum-power))