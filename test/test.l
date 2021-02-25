;;; -*- scheme -*-

;;; initial environment contains: t dlsym fsubr subr define

(define nil ())

(define flambda	(fsubr (dlsym "flambdaFsubr")))
(define lambda	(fsubr (dlsym "lambdaFsubr")))
(define let	(fsubr (dlsym "letFsubr")))
(define if	(fsubr (dlsym "ifFsubr")))
(define while	(fsubr (dlsym "whileFsubr")))
(define setq 	(fsubr (dlsym "setqFsubr")))

(define atom    (subr (dlsym "atomSubr")))
(define eq      (subr (dlsym "eqSubr")))
(define cond    (fsubr (dlsym "condFsubr")))

(define cons	(subr (dlsym "consSubr")))
(define rplaca	(subr (dlsym "rplacaSubr")))
(define rplacd	(subr (dlsym "rplacdSubr")))
(define car	(subr (dlsym "carSubr")))
(define cdr	(subr (dlsym "cdrSubr")))
(define eval	(subr (dlsym "evalSubr")))
(define apply	(subr (dlsym "applySubr")))
(define map	(subr (dlsym "mapSubr")))
(define assq	(subr (dlsym "assqSubr")))
(define println	(subr (dlsym "printlnSubr")))
(define +	(subr (dlsym "addSubr")))
(define -	(subr (dlsym "subtractSubr")))
(define *	(subr (dlsym "multiplySubr")))
(define /	(subr (dlsym "divideSubr")))
(define %	(subr (dlsym "modulusSubr")))
(define <	(subr (dlsym "lessSubr")))
(define <=	(subr (dlsym "lessEqualSubr")))
(define ==	(subr (dlsym "equalSubr")))
(define !=	(subr (dlsym "notEqualSubr")))
(define >=	(subr (dlsym "greaterEqualSubr")))
(define >	(subr (dlsym "greaterSubr")))

(define caar	(lambda (x) (car (car x))))
(define cadr	(lambda (x) (car (cdr x))))
(define cdar	(lambda (x) (cdr (car x))))
(define cddr	(lambda (x) (cdr (cdr x))))
(define cadar	(lambda (x) (car (cdr (car x)))))
(define caddar	(lambda (x) (car (cdr (cdr (car x))))))

(define quote	(flambda (form) (car form)))
(define quasiquote (fsubr (dlsym "quasiquoteFsubr")))
(define list	(lambda args args))

(define global-environment
  (let ((globals ((flambda (args env) env))))
    (lambda () globals)))

(define double (lambda (x) (+ x x)))
(double 21)

(define make-counter (lambda (n) (lambda () (setq n (+ n 1)))))
(define counter (make-counter 40))
(counter)
(counter)
(counter)
(counter)
(counter)

'(+ 3 4)

(eval '(+ 3 4))
(apply + 3 4)

(let ((x 0))
  (while (< x 10)
    (println (setq x (+ 1 x)))))

(setq *syntax-table*
      (cons (cons 'for
		  (flambda (form)
		    (list 'let (list (list (caar form) (cadar form)))
			  (list 'while (list '<= (caar form) (caddar form))
				(cadr form)
				(list 'setq (caar form) (list '+ 1 (caar form)))))))
	    *syntax-table*))

(for (i 0 10) (println i))

(define nfibs
  (lambda (n)
    (if (< n 2)
	1
	(+ 1 (nfibs (- n 1)) (nfibs (- n 2))))))

(nfibs 20)

(eval '(+ a b) (cons '(a . 3) (cons '(b . 4) (global-environment))))

(define dict '((foo . 1)(bar . 2)(baz . 3)))

(assq 'bar dict)

(define assqval (lambda (key alist) (cdr (assq key alist))))

(assqval 'foo dict)
(assqval 'bar dict)
(assqval 'baz dict)
(assqval 'qux dict)

((lambda (f) (f '(b c))) '(lambda (x) (cons 'a x)))

`(a ,(car '(b c)))

(define addvar (lambda (var) `(lambda (x) ,`(+ x ,var))))
;; quasiquote` has no effect on inner brackets. if want to pass inner, use ,` before brackets.

(define inc1 (addvar 1))
(inc1 12)

(define puts (dlsym "puts"))

(puts "Hello, world")

(define malloc		(dlsym "malloc"))
(define free		(dlsym "free"))
(define sprintf		(dlsym "sprintf"))

(let ((memory (malloc 1024)))
  (sprintf memory "Hello %s world %d" "primitive" 42)
  (puts memory) 
  (free memory))

(define set-int		(subr (dlsym "intPokeSubr")))
(define get-char	(subr (dlsym "charPeekSubr")))

(let ((memory (malloc 1024)))
  (set-int memory 0 0x01020304)
  (set-int memory 1 0x05060708)
  (sprintf memory "%02x %02x %02x %02x %02x %02x %02x %02x"
	   (get-char memory 0) (get-char memory 1) (get-char memory 2) (get-char memory 3)
	   (get-char memory 4) (get-char memory 5) (get-char memory 6) (get-char memory 7))
  (puts memory)
  (free memory))

(define set-char	(subr (dlsym "charPokeSubr")))
(define ptr->string	(subr (dlsym "primToStringSubr")))

(define make-string
  (lambda ()
    (let ((memory (malloc 8)))
      (set-char memory 0 65)
      (set-char memory 1 66)
      (set-char memory 2 67)
      (set-char memory 3 0)
      (puts memory)
      (let ((s (ptr->string memory)))
	(free memory)
	s))))

(cond ((eq 'a 'b) 'first) ((atom 'a) 'second))

(define sort-ins
  (lambda (arr v)
    (cond
      ((atom arr) (cons v '()))
      ((< v (car arr)) (cons v arr))
      ('t  (cons (car arr) (sort-ins (cdr arr) v)))
      )))

(sort-ins '(1 3 7) 2)
;; sort inster
;; => (1 2 3 7)

(define sort
  (lambda (arr rdy)
    (cond
      ((atom arr) rdy)
      ('t (sort (cdr arr) (sort-ins rdy (car arr))))
    )))

(sort '(49 38 65 97 76 13 27 49 10))
;; sort
;; => (10 13 27 38 49 49 65 76 97)

(define append
  (lambda (arr v)
    (cond
      ((atom arr) (cons v '()))
      ('t (cons (car arr) (append (cdr arr) v)))
      )))

(define reverse
  (lambda (arr)
    (cond
      ((atom arr) arr)
      ('t (append (reverse (cdr arr)) (car arr)))
      )))

(reverse '(1 2 3 4 5))
;; => (5 4 3 2 1)

(define heap (dlsym "heap_max_used"))
(define GC_count_objects (dlsym "GC_count_objects"))
(define GC_count_bytes (dlsym "GC_count_bytes"))

(let ((memory (malloc 1024)))
  (sprintf memory "heap memory used %d bytes." (heap))
  (puts memory) 
  (sprintf memory "alive: %d bytes in %d objects." (GC_count_bytes) (GC_count_objects))
  (puts memory) 
  (free memory))

(define exit (dlsym "exit"))
(exit 0)
