(define atom? (lambda (x) (cond ((list? x) #f) ((pair? x) #f) (#t #t))))
(define not? (lambda (x) (cond (x #f)(#t #t))))

(define add_mult (lambda (x) (cons (+ (car x) (cadr x)) (* (car x) (cadr x)))))

(define reduction (lambda (x g a) (cond
  ((eq? x '()) a)
  ((atom? x) (cons (car(g (cons x (cons (car a) '())))) (cons (cdr (g (cons x (cons (cadr a) '())))) '())))
  ;((not? (atom? (car x))) '(нізя))
  ((not? (atom? (car x))) (reduction (cdr x) g (reduction (car x) g a)))
  (#t (reduction (cdr x) g (cons (car(g (cons (car x) (cons (car a) '())))) (cons (cdr (g (cons (car x) (cons (cadr a) '())))) '()))))
)))

(reduction '() add_mult '(0 1))
(reduction '5 add_mult '(0 1))
(reduction '(1 2 3 4 5 6 7 8 9 10) add_mult '(0 1))
(reduction '(1 2 2 . 3) add_mult '(0 1))
(reduction '(1 2 (1 2) 2 . 3) add_mult '(0 1))