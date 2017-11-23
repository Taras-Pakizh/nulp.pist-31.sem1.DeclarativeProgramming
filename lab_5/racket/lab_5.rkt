(define atom? (lambda (x) (cond ((pair? x) #f)(#t #t))))

(define dx (lambda(l x)(cond
                          ((atom? l)(cond
                                      ((eq? l x) 1)
                                      (#t 0)))
                          (#t (apply (eval(car l)) (list (cdr l) 'x))))))

(define + (lambda(l x)
            (list '+ (dx (car l) x) (dx (cadr l) x))))

(define - (lambda(l x)
            (list '- (dx (car l) x) (dx (cadr l) x))))

(define * (lambda(l x)
            (list '+ (list '* (dx (car l) x) (cadr l))(list '* (car l) (dx (cadr l) x)))))

(define / (lambda(l x)
            (list '/ (list '- (list '* (dx (car l) x) (cadr l))(list '* (car l) (dx (cadr l) x))) (list '* (cadr l)(cadr l)))))

(define pow (lambda (l x) (list '* (list '* (cadr l) (list 'pow (car l) (list '- (cadr l) 1))) (dx (car l) x))))

(define cos (lambda (l x) (list '* (list '- '0 (list 'sin (car l))) (dx (car l) x))))


(dx '(* 88 (cos (* 91 (pow (cos y) 75)))) 'y)