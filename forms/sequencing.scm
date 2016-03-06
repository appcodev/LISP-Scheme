;; Sequencing

;; lambda with begin
(define print3
  (lambda (x y z)
    (begin
      (display x)
      (display "-")
      (display y)
      (display "-")
      (display z)
      (newline))))

;; with begin but without lambda
(define (print3 x y z)
  (begin
    (display x)
      (display "-")
      (display y)
      (display "-")
      (display z)
      (newline)))

;; lambda without begin
(define print3
  (lambda (x y z)
      (display x)
      (display "-")
      (display y)
      (display "-")
      (display z)
      (newline)))

;; without both lambda and begin
(define (print3 x y z)
    (display x)
    (display "-")
    (display y)
    (display "-")
    (display z)
    (newline))

;; begin with if
(define find-max
  (lambda (x y)
    (if (> x y)
        (begin
          (display x)
          (display " > ")
          (display y)
          (newline))
        (begin
          (display y)
          (display " > ")
          (display x)
          (newline)))))

;; > (find-max 10 -10)
;; 10 > -10

;; > (find-max 10 19)
;; 19 > 10