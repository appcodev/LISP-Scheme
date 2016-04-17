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

(define (move-pair state)
  (let ((num-list (car state)))
    ;; check length
    (if (and (> (length num-lst) 0)
             (<= (length num-lst) 4))
        ;; get-pair
        #t
      )))

(define (get-pair state index)
  #f
  
  )




  
  
