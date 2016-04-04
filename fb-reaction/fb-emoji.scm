;like
;love
;haha
;wow
(define like '((l i k e)
               (13 3 26 3 25 4 25 4 24 5 23 17 11 17 5 5 1 19 4 5 1 18 5 5 1 19 4 5 1 18 5 5 1 19 4 5 51)))
(define love '((l o v e)
               (4 7 6 8 6 11 3 11 2 14 1 72 1 28 1 27 3 25 5 22 8 19 12 16 15 12 19 9 22 4 13)))
(define haha '((h a h a)
               (8 13 14 17 10 5 2 7 2 5 6 5 6 3 6 5 3 5 2 4 2 1 2 4 2 5 1 32 23 6 2 19 2 7 2 17 2 4 1 4 2 2 11 2 2 4 3 4 17 4 6 6 9 6 10 17 14 13 8)))
(define wow '((w o w)
               (8 13 14 17 10 4 3 7 3 4 6 5 3 9 3 5 3 6 2 11 2 6 1 41 5 22 9 19 11 9 1 8 11 8 3 7 11 7 6 5 11 5 10 4 9 4 14 13 8)))


(define (reaction txt)
  (let* ((c 0))
    (define (dw p lm w)
      (if (= p lm) (display "")
          (begin (if (eq? w #t) (display " ")
                     (display (list-ref (car txt) (modulo (+ c 1)(length (car txt))))))
                 (set! c (+ c 1))
                 (if (= (modulo c 29) 0) (newline))
                 (dw (+ p 1) lm w))))
  (define (dwr d w)
    (if (null? d) (newline)
        (begin (dw 0 (car d) w)
               (dwr (cdr d) (not w)))))
    (dwr (cadr txt) #t)))