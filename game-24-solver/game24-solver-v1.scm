;; Game 24 solver
;; version 1.0
;; 17/4/2016

(require "my-func.ss")

;; state example
;; ((5 1 2 3) (0) ())
;; the first list (5 1 2 3) is remain numbers
;; the second list (0) is the result of operation
;; the third list () is sequence of operation 

;; goal state
;; (() (24) (.. abitary ..))
;; check match goal state for first and second list

(define state '((5 1 2 3)()()))

;; GET-MOVES
;; Algorithm I
;; 1. if length of remain number is less than or equal 4 then
;;       1.1 select number at index 1 operate for all operation are  +,-,* and / with others.
;;       1.2 change selected index to index 2 and do step 1 util finished the last index
;; 2. if length of remain number is 2 then
;;       2.1 operate the previous result with group of rest number

;; state : ((5 1 2 3)()())
;; (car state) : (5 1 2 3)
(define (move-pair state)
  (let ((num-list (car state)))
    ;; check length
    (if (and (> (length num-lst) 0)
             (<= (length num-lst) 4))
        ;; get-all-pairs
        #t
        #f
      )))

;; generate step by step
;; ex. state ((5 1 2 3)()())
;; 1. get-pair index 0
;; '() --> skip
;; 2. get-pair index 1,2,3
;; get-pair index (1)
;; ((5 1)(5 2)(5 3))
;; get-pair index (2)
;; ((1 2)(1 3))
;; get-pair index (3)
;; ((2 3))
;; all pair = ((5 1)(5 2)(5 3)(1 2)(1 3)(2 3))

;; 3. p = (car get-pair)
;; operate all operators (+ - * /)
;; p(0) = (5 1)
;; calculate (5+1) => ((2 3)(6)(5+1))
;; calculate (5-1) => ((2 3)(4)(5-1))
;; calculate (5*1) => ((2 3)(5)(5*1))
;; calculate (5/1) => ((2 3)(5)(5/1))
;; p(1) = (5 2) ... continuous operate all operators
;; p(2) do same p(0) p(1)

;; 4. result is all possible pairs of state

;; ex. state ((5 1 2 3)()())
;; lst-pair ((5 1)(5 2)(5 3)(1 2)(1 3)(2 3))
;; (generate-all '((5 1 3 2)()()))
;; (generate-all '((5 4 4 2)()()))

(define OPs '(+ - x ÷))
(define (generate-all state)
  (define (generate lst-pair)
    (cond ((null? lst-pair) '())
          (else 
           (append (cal-all state (car lst-pair) OPs)
                   (generate (cdr lst-pair))))))
  ;; body
  (generate (get-all-pairs state)))

;; all operators
(define (cal-all state pair lst-op)
  (cond ((null? lst-op) '())
        (else
         (append (cal-op state pair (car lst-op))
                 (cal-all state pair (cdr lst-op))))))

;; one operator
;; ex. case 4 numbers
;; state = ((5 4 4 2)()())
;; pairs = (((5 4) (5 2) (4 4) (4 2)))
;; pair  = (5 4)
;; op    = +
;; > (cal-op '((5 4 4 2)()()) '(5 4) '+)
;; (((4 2) (9) ((5 + 4))))

;; ex. case 2 numbers
;; state = ((4 2)(1)((5 - 4)))
;; pairs = ((4 1)(2 1))
;; pair  = (4 1)
;; op    = +
;; >  (cal-op '((4 2)(1)((5 - 4))) '(4 1) '+)
;; (((2) (5) ((4 + (5 - 4)))))

;; ex. case 1 number
;; > (cal-op '((2) (5) ((4 + (5 - 4)))) '(5 2) '+)
;; ((() (7) (((4 + (5 - 4)) + 2))))

(define (cal-op state pair op)
  (let ((rs (apply (symbol->operator op) pair))
        (nums (length (car state))))
    (if (integer? rs)
        (cond ((= nums 4)
               ;; for 4 numbers
               (list (list (remove-all (car state) 
                                       (remove-all pair (cadr state)))
                           (list (apply (symbol->operator op) pair))
                           (list (list (car pair) op (cadr pair))))))
              ((or (= nums 2) (= nums 1))
               ;; for 2 and 1 number(s)
               (let* ((new-num (car (remove-all pair (cadr state))))
                     (add-front? (> new-num (caadr state))))
                 ;; let* body
                 (list (list (remove-all (car state) 
                                         (remove-all pair (cadr state)))
                             (list (apply (symbol->operator op) pair))
                             (if add-front?
                                 (list (list new-num op (caaddr state)))
                                 (list (list (caaddr state) op new-num)))
                             ))))
              (else '()))
        ;; else rs isn't an integer.
        '())))

;; pair index 0 to n-1
;; where n is length of (car state)
;; ex.
;; >  (get-all-pairs '((5 3 1 2)()()))
;; ((5 3) (5 1) (5 2) (3 1) (3 2) (2 1))
;; >  (get-all-pairs '((5 3 3 2)()()))
;; ((5 3) (5 2) (3 3) (3 2))
;; >  (get-all-pairs '((4 4 4 3)()()))
;; ((4 4) (4 3))
;; >  (get-all-pairs '((3 3 3 3)()()))
;; ((3 3))

(define (get-all-pairs state)
  (define (all-pairs index)
    (cond ((>= index (length (car state))) '())
          (else
           (append (get-pair state index)
                   (all-pairs (+ index 1))))))
  (remove-dup (all-pairs 0)))

;; state : ((5 1 2 3)()())
;; index : 0
;; output : ()
;; index : 1
;; output : ((5 1)(5 2)(5 3))
;; index : 2
;; output : ((1 2)(1 3))
;; index : 3 (n-1)
;; output : ((2 3))

;; state : ((2 3)(6)(5+1))
;; index : 0
;; output : ((6 2)(6 3))
;; index : 1 (n-1)
;; output : ((2 3))

(define (get-pair state index)
  (let ((x (get-x state index)))
    ;; inner function
    (define (make-pair state x next-index)
      (let ((next (get-x state next-index)))
        (cond ((null? next) '())
              (else
               (cons (sort > (list x next))
                     (make-pair state x (+ next-index 1)))))))
    ;; body
    (cond ((null? x) '())
          (else
           (make-pair state x (+ index 1))))))

;; state : ((5 1 2 3)()())
;; index 0 : ()
;; index 1 : 5
;; index 2 : 1
;; index 3 : 2
;; index 4 : 3

;; state : ((2 3)(6)(5+1))
;; index 0 : 6
;; index 1 : 2
;; index 2 : 3

(define (get-x state index)
  (if (and (>= index 0)
           (<= index (length (car state))))
      (cond ((= index 0) 
             (if (null? (cadr state))
                 '() 
                 (caadr state)))
            (else
             (list-ref (car state) (- index 1))))
      '()))




  
  
