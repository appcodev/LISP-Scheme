(require (lib "servlet.ss" "web-server"))

; Request -> Request
(define (get-login-information request0)
  (let* ([bindings (request-bindings request0)]
         [name (extract-bindings 'Name bindings)]
         [form '((input ([type "text"][name "Name"][value ""]))
                 (br)
                 (input ([type "password"][name "Passwd"]))
                 (br)
                 (input ([type "submit"][value "Login"])))])
    (if (null? name)
        (send/suspend
         (build-suspender
          '("Login")
          form))
        (send/suspend
         (build-suspender
          '("Repeat Login")
          `(("Dear "
             ,(car name)
             " your username didn't match your password. Please try again."
             (br))
            ,@form))))))

; Request -> Void
(define (check-login-information request)
  (let* ([bindings (request-bindings request)]
         [name     (extract-binding/single 'Name bindings)]
         [passwd   (extract-binding/single 'Passwd bindings)])
    (if (and (string=? "Paul" name) (string=? "Portland" passwd))
        request
        (check-login-information (get-login-information request)))))

; Request -> Void
(define (welcome request)
  (let ([bindings (request-bindings request)])
    (send/finish
     `(html
       ,(extract-binding/single 'Name bindings)
       " Thanks for using our service."
       " We're glad you recalled that your password is "
       ,(extract-binding/single 'Passwd bindings)))))

; RUN:
;;(welcome
;; (check-login-information
;;  (get-login-information initial-request)))