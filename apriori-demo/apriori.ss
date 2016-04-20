;; Apriori Module
(module Apriori mzshceme
  
  ;; function
  
  ;; frequently items set
  (define (freq-items data goods min-sup)
    ;; find frequently items set at level
    (define (freq-level level items freq-items-lst)
      (cond ((= level 2) '())
            (else #f)
            )
      )
    
    (freq-level 1 goods))
  
  ;; get all possible
  (define (get-all goods level)
    )
  
  ;; in? check match to data
  ;; data - record input
  ;; items - '(a) or '(a b) or '(a b c)
  (define (in? record items)
    (cond ((null? items) #t)
          ((member? (car items) record)
           (in? record (cdr items)))
          (else
           #f )))
  
  ;; count-in
  (define (count-in data items)
    (cond ((null? data) 0)
          ((in? (car data) items) 
           (+ 1 (count-in (cdr data) items)))
          (else
           (count-in (cdr data) items))))
  
  
  ;; export
  (provide freq-items)
  
  )