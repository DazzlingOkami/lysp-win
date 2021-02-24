;; Lisp machine

;; Base syntax keywords
(define nil ())
(define flambda (fsubr (dlsym "flambdaFsubr")))
(define lambda  (fsubr (dlsym "lambdaFsubr")))
(define list    (lambda args args))

;; Seven original operation symbols
(define quote   (flambda (form) (car form)))
(define atom    (subr (dlsym "atomSubr")))
(define eq      (subr (dlsym "eqSubr")))
(define car     (subr (dlsym "carSubr")))
(define cdr     (subr (dlsym "cdrSubr")))
(define cons    (subr (dlsym "consSubr")))
(define cond    (fsubr (dlsym "condFsubr")))

;; Groups
(define caar    (lambda (x) (car (car x))))
(define cadr    (lambda (x) (car (cdr x))))
(define cdar    (lambda (x) (cdr (car x))))
(define cddr    (lambda (x) (cdr (cdr x))))
(define cadar   (lambda (x) (car (cdr (car x)))))
(define caddr   (lambda (x) (car (cdr (cdr x)))))
(define caddar  (lambda (x) (car (cdr (cdr (car x))))))

;; Useful
(defun null. (x)
  (eq x '()))

(defun and. (x y)
  (cond (x (cond (y 't) ('t '())))
        ('t '())))

(defun not. (x)
  (cond (x '())
        ('t 't)))

(defun append. (x y)
   (cond ((null. x) y)
         ('t (cons (car x) (append. (cdr x) y)))))

(defun pair. (x y)
  (cond ((and. (null. x) (null. y)) '())
        ((and. (not. (atom x)) (not. (atom y)))
         (cons (list (car x) (car y))
               (pair. (cdr) (cdr y))))))

(defun assoc. (x y)
  (cond ((eq (caar y) x) (cadar y))
        ('t (assoc. x (cdr y)))))


;; It's amazing
;; (eval. '(cons x '(b c)) '((x a) (y b)))
;; -> (cons 'a '(b c))
;; (eval. '(quote a))
;; (eval. 'x '((x a) (y b)))
;; (eval. '(f '(b c)) '((f (lambda (x) (cons 'a x)))))
(defun eval. (e a)
  (cond 
    ((atom e) (assoc. e a))
    ((atom (car e))
     (cond 
       ((eq (car e) 'quote) (cadr e))
       ((eq (car e) 'atom)  (atom   (eval. (cadr e) a)))
       ((eq (car e) 'eq)    (eq     (eval. (cadr e) a)
                                    (eval. (caddr e) a)))
       ((eq (car e) 'car)   (car    (eval. (cadr e) a)))
       ((eq (car e) 'cdr)   (cdr    (eval. (cadr e) a)))
       ((eq (car e) 'cons)  (cons   (eval. (cadr e) a)
                                    (eval. (caddr e) a)))
       ((eq (car e) 'cond)  (evcon. (cdr e) a))
       ('t (eval. (cons (assoc. (car e) a)
                        (cdr e))
                  a))))
    ((eq (caar e) 'label)
     (eval. (cons (caddar e) (cdr e))
            (cons (list (cadar e) (car e)) a)))
    ((eq (caar e) 'lambda)
     (eval. (caddar e)
            (append. (pair. (cadar e) (evlis. (cdr  e) a))
                     a)))))

(defun evcon. (c a)
  (cond ((eval. (caar c) a)
         (eval. (cadar c) a))
        ('t (evcon. (cdr c) a))))

(defun evlis. (m a)
  (cond ((null. m) '())
        ('t (cons (eval.  (car m) a)
                  (evlis. (cdr m) a)))))
