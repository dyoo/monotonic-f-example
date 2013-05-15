#lang racket/base

;;
(define (test-module-with-monotonic-f module-name)
  (define ns (make-base-namespace))
  (eval #`(module foo racket
            (require rackunit
                     #,module-name)
            
            (check-true (> (f 1) (f 0))
                        (format "~a fails to provide monotonic f" #,module-name)))
        ns))

