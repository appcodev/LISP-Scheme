(define A '(AAa 25)) ;; A, name is AAa and value is 25
(define B '(BBb 30)) ;; B, name is BBb and value is 30
(define C '(CCc 21)) ;; C, name is CCc and value is 21

;; Compare the most value of three values; A,B and C
(if (>= (cadr A) (cadr B)) ;; A >= B ?
    ;; if A >= B
    (if (>= (cadr A) (cadr C)) ;; A >= C ?
        (display (car A))  ;; if A >= C display 'A (true)
        (display (car C))) ;; if A < C  display 'C (false)
    ;; if A < B
    (if (>= (cadr B) (cadr C)) ;; B >= C ?
        (display (car B))  ;; if B >= C display 'B (true)
        (display (car C))) ;; if B < C  display 'C (false)
    )
