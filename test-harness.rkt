#lang racket

;;
(define (test-module-with-monotonic-f module-path-name)
  (define ns (make-base-namespace))
  (printf "testing ~s\n" module-path-name)
  (eval `(begin (module a-test-module racket/base
                  (require rackunit
                           (file ,(path->string module-path-name)))
                  (check-true (> (f 1) (f 0))
                              (format "~a fails to provide monotonic f" ,module-path-name))
                  (check-true (> (f 3) (f 2))
                              (format "~a fails to provide monotonic f" ,module-path-name)))
                (require 'a-test-module))
        ns))


(for ([mod-name (in-directory "impls")]
      #:when (equal? (filename-extension mod-name) #"rkt"))
  (test-module-with-monotonic-f mod-name))