(load "lib.l")

(define zero? (lambda (x) (== x 0)))
(define sub1  (lambda (x) (-  x 1)))

(define factorial
  (lambda (n)
        ((lambda (fact)
           ((fact fact) n))
         (lambda (fact)
           (lambda (n)
             (if (zero? n)
                 1
                 (* n ((fact fact) (sub1 n)))))))))
(factorial 5)
;; => 120

(define factorial-cps
  (lambda (n k)
    ((lambda (fact k) (fact fact (lambda (v0) (v0 n k))))
     (lambda (fact k)
       (k
        (lambda (n k)
          (if (zero? n)
            (k 1)
            (fact
             fact
             (lambda (v1) (v1 (sub1 n) (lambda (v2) (k (* n v2))))))))))
     k))
)

(factorial-cps 5 (lambda (v) v))
;; => 120
