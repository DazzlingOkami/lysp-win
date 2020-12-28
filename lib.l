;;; -*- scheme -*-

;;; initial environment contains: t dlsym fsubr subr define

(define nil ())

(define flambda (fsubr (dlsym "flambdaFsubr")))
(define lambda  (fsubr (dlsym "lambdaFsubr")))
(define let     (fsubr (dlsym "letFsubr")))
(define if      (fsubr (dlsym "ifFsubr")))
(define while   (fsubr (dlsym "whileFsubr")))
(define setq    (fsubr (dlsym "setqFsubr")))

(define and     (fsubr (dlsym "andFsubr")))
(define or      (fsubr (dlsym "orFsubr")))

(define cons    (subr (dlsym "consSubr")))
(define rplaca  (subr (dlsym "rplacaSubr")))
(define rplacd  (subr (dlsym "rplacdSubr")))
(define car     (subr (dlsym "carSubr")))
(define cdr     (subr (dlsym "cdrSubr")))
(define eval    (subr (dlsym "evalSubr")))
(define apply   (subr (dlsym "applySubr")))
(define map     (subr (dlsym "mapSubr")))
(define assq    (subr (dlsym "assqSubr")))

(define println (subr (dlsym "printlnSubr")))

(define +  (subr (dlsym "addSubr")))
(define -  (subr (dlsym "subtractSubr")))
(define *  (subr (dlsym "multiplySubr")))
(define /  (subr (dlsym "divideSubr")))
(define %  (subr (dlsym "modulusSubr")))
(define <  (subr (dlsym "lessSubr")))
(define <= (subr (dlsym "lessEqualSubr")))
(define == (subr (dlsym "equalSubr")))
(define != (subr (dlsym "notEqualSubr")))
(define >= (subr (dlsym "greaterEqualSubr")))
(define >  (subr (dlsym "greaterSubr")))

(define caar  (lambda (x) (car (car x))))
(define cadr  (lambda (x) (car (cdr x))))
(define cdar  (lambda (x) (cdr (car x))))
(define cddr  (lambda (x) (cdr (cdr x))))
(define cadar (lambda (x) (car (cdr (car x)))))
(define caddar (lambda (x) (car (cdr (cdr (car x))))))

(define quote (flambda (form) (car form)))
(define list  (lambda args args))

(define global-environment
  (let ((globals ((flambda (args env) env))))
    (lambda () globals)))

(setq *syntax-table*
      (cons (cons 'for
      (flambda (form)
        (list 'let (list (list (caar form) (cadar form)))
        (list 'while (list '<= (caar form) (caddar form))
        (cadr form)
        (list 'setq (caar form) (list '+ 1 (caar form)))))))
      *syntax-table*))

(define puts    (dlsym "puts"))
(define sprintf (dlsym "sprintf"))

(define malloc  (dlsym "malloc"))
(define free    (dlsym "free"))

(define set-int   (subr (dlsym "intPokeSubr")))
(define get-char  (subr (dlsym "charPeekSubr")))
(define set-char  (subr (dlsym "charPokeSubr")))

(define ptr->string (subr (dlsym "primToStringSubr")))

(define exit (dlsym "exit"))

(define heap (dlsym "heap_max_used"))
(define GC_count_objects  (dlsym "GC_count_objects"))
(define GC_count_bytes    (dlsym "GC_count_bytes"))
(define GC                (dlsym "GC_gcollect"))

(define meminfo 
  (lambda ()
    (let ((str (malloc 1024)))
         (sprintf str "heap memory used %d bytes." (heap))
         (puts str)
         (sprintf str "alive: %d bytes in %d objects." (GC_count_bytes) (GC_count_objects))
         (puts str)
         (free str)
         0
    )
  )
)
