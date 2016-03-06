;; Apply, ex. 1 basic
(apply + '(3 2 4 5))
;; 14
(apply * '(3 2 4 5))
;; 120
(apply min '(3 2 4 5))
;; 2
(apply max '(3 2 4 5))
;; 5

;; Apply, ex. 2
(define x '(20 30 40))
(apply + x)
;; 90
(apply + 10 20 30 x)
;; 150
x
;;(20 30 40)