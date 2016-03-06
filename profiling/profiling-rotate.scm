(define (clock-wise lst)
  (let ((x1 (car lst))
         (x2 (cadr lst))
         (x3 (caddr lst))
         (x4 (cadddr lst)))
     (list x4 x1 x2 x3)))

