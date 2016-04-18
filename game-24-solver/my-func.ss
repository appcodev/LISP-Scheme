;; my-functions
(module my-func mzscheme
  ;; require
  (require (lib "list.ss")
           (lib "compat.ss"))
  ;; replace
  (define (replace lst index rep-with)
    (cond ((null? lst) '())
          ((= index 0) 
           (cons rep-with
                 (replace (cdr lst) (- index 1) rep-with)))
          (else 
           (cons (car lst)
                 (replace (cdr lst) (- index 1) rep-with)))))
  
  ;; remove-all
  (define (remove-all lst lst-rmv)
    (cond ((null? lst-rmv) lst)
          (else
           (remove-all (remove (car lst-rmv) lst)
                       (cdr lst-rmv)))))
  
  
  ;; remove-all-by-index
  (define (remove-all-indx lst lst-index)
    (remove-lst lst
                (sort < lst-index)))
  
  (define (remove-lst lst lst-index)
      (cond ((null? lst-index) lst)
            (else 
             (remove-lst (remove-x lst (car lst-index)) 
                     (map minus1 (cdr lst-index))))))
  
  (define (minus1 x) (- x 1))
  (define (remove-x lst index)
    (cond ((null? lst) '())
          ((= index 0)
           (remove-x (cdr lst) (- index 1)))
          (else
           (cons (car lst)
                 (remove-x (cdr lst) (- index 1))))))
  
  ;; remove duplicate
  ;; ((5 3) (5 3) (5 2) (3 3) (3 2) (3 2))
  ;; > ((5 3) (5 2) (3 3) (3 2))
  (define (remove-dup lst)
    (cond ((null? lst) '())
          ((member (car lst) (cdr lst))
           (remove-dup (cdr lst)))
          (else
           (cons (car lst)
                 (remove-dup (cdr lst))))
          ))
  
  ;; symbol->operator
  (define (symbol->operator op)
    (cond ((eq? op '+) +)
          ((eq? op '-) -)
          ((eq? op 'x) *)
          ((eq? op '÷) /)
          (else #f)))
  
  ;; operator->symbol
  (define (operator->symbol op)
    (cond ((equal? op +) '+)
          ((equal? op -) '-)
          ((equal? op *) 'x)
          ((equal? op /) '÷)
          (else #f)))
  
  ;; export
  (provide replace)
  (provide remove-all)
  (provide remove-all-indx)
  (provide remove-dup)
  (provide symbol->operator)
  (provide operator->symbol)
  (provide sort))