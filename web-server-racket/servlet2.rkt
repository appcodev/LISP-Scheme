#lang racket
(require web-server/http
         web-server/managers/none
         web-server/servlet
         web-server/servlet-env)

(provide interface-version manager start)
 
(define interface-version 'v2)
(define manager
  (create-none-manager
   (lambda (req)
     (response/xexpr
      `(html (head (title "No Continuations Here!"))
             (body (h1 "No Continuations Here!")))))))
(define (start req)
  (response/xexpr
   `(html (head (title "Hello World!"))
          (body (h1 "Hi Mom!")))))

;; (serve/servlet start)