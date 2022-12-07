(ns tuning-trouble.core
  (:gen-class))

;; Return a sequence of 14-character substrings, each starting at successive
;; character positions of S.
(defn sliding-window [s]
  (lazy-seq
   (when (>= (count s) 14)
     (cons (subs s 0 14) (sliding-window (subs s 1))))))

;; Test if the 14 character string is a marker, i.e. all chars are distinct.
(defn not-marker-p [s]
  (not (= 14 (count (set s)))))         ;Make a set of the chars, check if length = 14.

(defn -main
  "Advent of Code Day 6, part 2."
  [& args]
  (+ 14 (count (take-while not-marker-p (sliding-window (slurp "../input"))))))
