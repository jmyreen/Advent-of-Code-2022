(ns tuning-trouble.core
  (:gen-class))

;; Return a sequence of four-character substrings, each starting at successive
;; character positions of S.
(defn sliding-window [s]
  (lazy-seq
   (when (>= (count s) 4)
     (cons (subs s 0 4) (sliding-window (subs s 1))))))

;; Test if the four character string is a marker, i.e. all chars are different.
(defn not-marker-p [s]
  (let [[c1 c2 c3 c4] s]
    (not (and (not= c1 c2) (not= c1 c3) (not= c1 c4) (not= c2 c3) (not= c2 c4) (not= c3 c4)))))

(defn -main
  "Advent of Code Day 6, part 1."
  [& args]
  (+ 4 (count (take-while not-marker-p (sliding-window (slurp "../input"))))))
