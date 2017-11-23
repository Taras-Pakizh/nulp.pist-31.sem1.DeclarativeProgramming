(ns lab-2.core)

;16

(defn atom-count [x] (cond
  (= x '()) 0
  (list? x) (+ (atom-count (first x)) (atom-count (rest x)))
  :else 1
))

(defn -main [& args] (do
  (println (atom-count '(1 true 2 0.1 (0 6 (0 true . 5)  ((((((((((((((((((((((((8((((())))))))))))))))))))))))))))) (8 . 9) () 7) 3 4 . 5)))
  (println (atom-count '()))
  (println (atom-count '(1 . 2)))
  (println (atom-count '1))
  (println (atom-count '(1 2 . 3)))
))