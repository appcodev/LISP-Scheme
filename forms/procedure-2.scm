(define (area w h)
  (* w h))
;; > (area 10 5)
;; 50

(define area *)
;; > (area 12 10)
;; 120


(define print
  (lambda (x . z)
    (display x)
    (display z)))
;; -- ex. 1
;; > (print 10 5)
;; 10(5)
;; -- ex. 2
;; > (print '(a b c) 5)
;; (a b c)(5)
;; -- ex. 3
;; > (print '(a b) '(1 2))
;; (a b)((1 2))

(define (print2 x . z)
  (display x)
  (display z))


(define sumX3
  (lambda (a b c)
    (* (+ a b c) 3)))
;; > (sumX3 15 16 17)
;; 144


(define hello
  (lambda ()
    (display "hello")))


;; with lambda
(define sayhi-l
  (lambda ()
    (display "Hi!")))
;; > (sayhi-l)
;; Hi!

;; without lambda
(define (sayhi)
  (display "hi"))
;; > (sayhi)
;; hi

(define search
  (lambda (a b c . x)
    (display (member a x))
    (display (member b x))
    (display (member c x))))

;;>  (search 'A 1 'b 34 2 1 'b 'c 'd)
;;   #f(1 b c d)(b c d)