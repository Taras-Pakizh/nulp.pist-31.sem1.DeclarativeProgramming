(ns lab-3.core)

(defn atom? [x] (cond (list? x) false :else true))
(defn and? [x y] (cond (= x false) false (= y false) false :else true))
(defn or? [x y] (cond x true y true :else false))
(defn not? [x] (cond x false :else true))

(defn in? [list x] (cond
  (empty? list) false
  (= list x) true
  (= x (first list)) true
  (= x (rest list)) true
  :else (in? (rest list) x)
))

(defn not-in? [list x] (not? (in? list x)))

(defn symmetric-difference-recursion [x y list] (cond
  (= x '()) list
  (and? (list? x) (and? (not-in? y (first x)) (not-in? list (first x)))) (symmetric-difference-recursion (rest x) y (conj list (first x)))
  :else (symmetric-difference-recursion (conj '() x) y list)
))

(defn symmetric-difference [x y] (symmetric-difference-recursion y x (symmetric-difference-recursion x y '())))

(defn -main [& args] (do
                       ;(println (symmetric-difference 'q '(a b a . b)))
                       (println (symmetric-difference '(4 5 (2 3 . 4) () 2 3 (2 3 .4)) '(() 6 1 (2 3 . 4) 2)))
                       ;(println (symmetric-difference '((a . b) (c . d) m . k) '(a b a . b)))
                       ;(println (symmetric-difference '(((1 . 2)) (3 . 4) 5 . 6) '((5 . 6) (3 . 7) 1 . 2)))
))