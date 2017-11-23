(ns lab-1.core)

;9
(defn xor [x y] (cond (= x y) false :else true))

(defn -main [& args] (do
  (println (xor false false))
  (println (xor false true))
  (println (xor true false))
  (println (xor true true))
))