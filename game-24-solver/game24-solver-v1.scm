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

(define state-1 '((5 1 2 3)()()))
(define state-2 '((5 4 4 2)()()))
(define state-3 '((4 4 4 4)()()))
(define state-4 '((7 8 8 4)()()))
(define goal '(()(24)()))

;; GET-MOVES
;; Algorithm I
;; 1. if length of remain number is less than or equal 4 then
;;       1.1 select number at index 1 operate for all operation are  +,-,* and / with others.
;;       1.2 change selected index to index 2 and do step 1 util finished the last index
;; 2. if length of remain number is 2 then
;;       2.1 operate the previous result with group of rest number

;; state : ((5 1 2 3)()())
;; (car state) : (5 1 2 3)
(define (GET-MOVES state)
  (let ((num (car state)))
    ;; check length
    (if (and (> (length num) 0)
             (<= (length num) 4))
        ;; get-all-pairs
        (generate-all state)
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
;; pairs = ((4 1)(2 1)(4 2))
;; pair  = (4 1)
;; op    = +
;; >  (cal-op '((4 2)(1)((5 - 4))) '(4 1) '+)
;; (((2) (5) ((4 + (5 - 4)))))

;; ex. case 2 numbers and group pair
;; state = ((4 2)(1)((5 - 4)))
;; pair  = (4 2)
;; op    = +
;; > (cal-op '((4 2) (1) ((5 - 4))) '(4 2) '+)
;; ((() (7) (((4 + 2) + (5 - 4))))
;;  (() (3) (((4 - 2) + (5 - 4))))
;;  (() (9) (((4 x 2) + (5 - 4))))
;;  (() (3) (((4 ÷ 2) + (5 - 4)))))

;; ex. case 1 number
;; > (cal-op '((2) (5) ((4 + (5 - 4)))) '(5 2) '+)
;; ((() (7) (((4 + (5 - 4)) + 2))))

(define (cal-op state pair op)
  (let* ((div-by-zero? (and (eq? op '÷) 
                            (not (null? (cadr state))) 
                            (= (caadr state) 0)))
         (rs (if (not div-by-zero?)
                 (apply (symbol->operator op) pair) #f))
         (nums (length (car state))))
    (if (integer? rs)
        (cond ((= nums 4)
               ;; for 4 numbers
               (list (list (remove-all (car state) 
                                       (remove-all pair (cadr state)))
                           (list rs)
                           (list (list (car pair) op (cadr pair))))))
              ((or (= nums 2) (= nums 1))
               ;; for 2 and 1 number(s)
               (let* ((remain-num (length (remove-all (car state) pair)))
                      (new-num (car (remove-all pair (cadr state))))
                      (add-front? (> new-num (caadr state))))
                 ;; body
                 (if (and (= (length (car state)) 2) 
                          (= remain-num 0)) 
                     ;; pair group case ((a op b) op (x op y))
                     ;; pair group
                     (get-pair-group state pair op)
                     ;; non-pair group
                     (list (list (remove-all (car state) 
                                             (remove-all pair (cadr state)))
                                 (list rs)
                                 (if add-front?
                                     (list (list new-num op (caaddr state)))
                                     (list (list (caaddr state) op new-num))))))
                     ))
              (else '()))
        ;; else rs isn't an integer.
        '())))

;; pair-group
;; state = ((4 4)(8)((4 + 4)))
;; pair  = (4 4)
;; op    = +
;; test 
;; > (get-pair-group '((4 4)(8)((4 + 4))) '(4 4) '÷) ;; change operator to +, -, x
(define (get-pair-group state pair op)
  (define (pair-group g-op)
    (cond ((null? g-op) '())
          (else
           (let* ((pair-rs (apply (symbol->operator (car g-op)) pair)) ;; pair result
                  (more? (> pair-rs (caadr state))) ;; more? = #t, if pair-rs > (caadr state)
                  (div-by-zero? (or (and (eq? op '÷) (= (caadr state) 0))
                                    (and (eq? op '÷) (= pair-rs 0))))
                  (rs (if (not div-by-zero?)
                          (if more? 
                              (apply (symbol->operator op) (list pair-rs (caadr state)))
                              (apply (symbol->operator op) (list (caadr state) pair-rs)))
                          #f)))
             ;; body
             (if (integer? rs)
                 (cons (list (remove-all (car state) pair)
                             (list rs)
                             (if more?
                                 (list (list (list (car pair) (car g-op) (cadr pair)) op (caaddr state)))
                                 (list (list (caaddr state) op (list (car pair) (car g-op) (cadr pair))))))
                       ;; cons with ...
                       (pair-group (cdr g-op)))
                       
                 ;; rs is not an integer, do next group operator
                 (pair-group (cdr g-op))))
           )))
  
  (pair-group OPs))

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


;; -------------------- Search function ----------------

;; match?
(define (match? state goal)
  (and (equal? (car state) (car goal))
       (equal? (cadr state) (cadr goal))))
  
;; BFS + visited list
(define (BFS-nocycles startState goalState)
  
  (define (BFS-paths paths)
    (cond ((null? paths) #f)
          ((match? (caar paths) goalState) (car paths))
          (else (BFS-paths (append (cdr paths)
                                   (extend-all (car paths) (GET-MOVES (caar paths))))))))
  
  (define (extend-all path nextStates)
    (cond ((null? nextStates) '())
          ((equal? nextStates #f) '())
          ((member (car nextStates) path) (extend-all path (cdr nextStates)))
          (else (cons (cons (car nextStates) path)
                      (extend-all path (cdr nextStates))))))
  
  (BFS-paths (list (list startState))))


;; ------------ Test All number 1 1 1 1 to 9 9 9 9 ---------
(define (next-number n)
  (let ((n1 (list-ref n 0))
        (n2 (list-ref n 1))
        (n3 (list-ref n 2))
        (n4 (list-ref n 3)))
    
    (if (> (+ n4 1) 9) 
        (begin 
          (set! n4 1)
          (if (> (+ n3 1) 9)
              (begin
                (set! n3 1)
                (if (> (+ n2 1) 9)
                    (begin
                      (set! n2 1)
                      (if (> (+ n1 1) 9)
                          #f
                          (list (+ n1 1) n2 n3 n4)))
                    (list n1 (+ n2 1) n3 n4)))
              (list n1 n2 (+ n3 1) n4)))
        (list n1 n2 n3 (+ n4 1)))))

(define (make-number number)
  (let ((new-number (next-number number)))
    (if (equal? new-number #f) (list number)
        (cons number (make-number new-number)))
    ))

;; all-number
(define all-numbers (make-number '(1 1 1 1)))

;; test
(define (test-search lst f!)
  (cond ((null? lst) #f)
        (else
         (begin
           (display (car lst))
           (newline)
           (let* ((solv (BFS-nocycles (list (car lst) () ()) goal))
                  (nwf! (if (equal? solv #f) (+ f! 1) f!)))
             (display solv)
             (if (> nwf! f!)
                 (begin
                   (display " ")
                   (display nwf!)))
             (newline)
             (test-search (cdr lst) nwf!)
             )
           ))))

(test-search all-numbers 0)




  
  
