;; my-fibonacci.ss
(module my-fibonacci mzscheme
  
  ;; functions
  ;; fibo?
  (define (fibo? n)
    (define (check-i i)
      (let ((rs (fibo-loop i)))
        (cond ((> rs n) #f) 
              ((= rs n) #t)
              (else 
               (check-i (+ i 1))))
        ))
    
    (if (number? n)
        (check-i 0)
        #f))
  
  ;; fibo-loop
  (define (fibo-loop i)
    (cond ((not (integer? i)) #f)
          ((< i 0) #f)
          ((= i 0) 0)
          ((= i 1) 1)
          (else
           (+ (fibo-loop (- i 1))
              (fibo-loop (- i 2))))
          ))
  
  ;; export
  (provide fibo?)
  )