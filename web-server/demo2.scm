 (require (lib "servlet.ss" "web-server"))
 
 (define interface-version 'v1)
 (define timeout +inf.0)
 
 (define (start initial-request)
   (send/finish
    `(html
      (body (p (format "~a" (request-bindings initial-request)))))))