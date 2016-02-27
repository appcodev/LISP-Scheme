(define score 55.91)

(cond ((>= score 90) 'A+)  ;; score >= 90 return A+
      ((>= score 80) 'A)   ;; score >= 80 return A
      ((>= score 70) 'B)   ;; score >= 70 return B
      ((>= score 60) 'C)   ;; score >= 60 return C
      ((>= score 50) 'D)   ;; score >= 50 return D
      (else               
       'F)                 ;; else/default return F
      ) ;; end cond