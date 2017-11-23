;9
(define xor (lambda (x y)
    (cond
      ((eq? x y) #f)
      (#t #t)
    )
))

(xor #f #f)
(xor #f #t)
(xor #t #f)
(xor #t #t)