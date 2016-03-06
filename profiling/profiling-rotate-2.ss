;; this code use DrScheme version 4.2.5, its extension file is .ss
;; you can this file for test with older version

(define (clock-wise lst)
  (let ((x1 (car lst))
        (x2 (cadr lst))
        (x3 (caddr lst))
        (x4 (cadddr lst)))
    (list x4 x1 x2 x3)))

(define (clock-wise2 lst)
  (let ((x1 (list-ref lst 0))
        (x2 (list-ref lst 1))
        (x3 (list-ref lst 2))
        (x4 (list-ref lst 3)))
    (list x4 x1 x2 x3)))

(define (clock-wise3 lstA)
  (define (get-last lst)
    (cond ((null? lst) '())
          ((eq? (cdr lst) '()) (car lst))
          (else (get-last (cdr lst)))))
  (define (del-last lst)
    (cond ((null? lst) '())
          ((eq? (cdr lst) '()) '())
          (else
           (cons (car lst)
                 (del-last (cdr lst))))
          ))
  (cons (get-last lstA)
        (del-last lstA))
  )

(define (clock-wise-all lst)
  (begin
    (list (clock-wise lst)
          (clock-wise2 lst)
          (clock-wise3 lst))))

