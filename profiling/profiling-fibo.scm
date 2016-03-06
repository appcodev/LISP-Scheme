(define (fibo n)
  (cond ((<= n 2) 1)
        (else
         (+ (fibo (- n 1)) 
            (fibo (- n 2))))))

(define (list-fibo n)
  (define (value-list-fibo n)
    (cond ((= n 0) '())
        (else
          (append (list (fibo n))
                  (value-list-fibo (- n 1)))
         )))
  (reverse (value-list-fibo n)))