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
  
  ;; remove
  (define (remove! lst lst-index)
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
  
  
  ;; export
  (provide replace)
  (provide remove!))