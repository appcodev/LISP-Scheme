(define u '(5 6 7 6 8 10 3 10 4 13 1 13 1 87 1 27 4 23 7 20 11 16 16 11 20 7 24 3 27 1))
(define u2 '(5 6 7 6 8 10 3 10 4 13 1 13 1 68 4 3 5 7 1 9 5 2 5 6 4 8 4 1 5 5 7 8 8 4 11 7 6 3 16 5 4 2 21 4 1 2 24 3 27 1))
(define (lov3 u)
  (let* ((c 0))
    (define (dw p lm w)
      (if (= p lm) (display "")
          (begin (if (eq? w #t) (display " ")
                     (display (list-ref '(l o v e) (modulo (+ c 1) 4))))
                 (set! c (+ c 1))
                 (if (= (modulo c 29) 0) (newline))
                 (dw (+ p 1) lm w))))
  (define (dwr d w)
    (if (null? d) (newline)
        (begin (dw 0 (car d) w)
               (dwr (cdr d) (not w)))))
    (dwr u #t)))