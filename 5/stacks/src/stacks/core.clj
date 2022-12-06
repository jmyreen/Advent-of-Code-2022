(ns stacks.core
  (:gen-class))

(require 'clojure.java.io)

(def stacks [
             '()
             '("F" "T" "N" "Z" "M" "G" "H" "J")
             '("J" "W" "V")
             '("H" "T" "B" "J" "L" "V" "G")
             '("L" "V" "D" "C" "N" "J" "P" "B")
             '("G" "R" "P" "M" "S" "W" "F")
             '("M" "V" "N" "B" "F" "C" "H" "G")
             '("R" "M" "G" "H" "D")
             '("D" "Z" "V" "M" "N" "H")
             '("H" "F" "N" "G")
             ])

;; Move N items from stack FROM to stack TO. Return the stacks vector.
(defn move-items [stks moves]
  "Move n items from one stack to another."
  ;; Move items from stack :from to stack :to :n times.
  (loop [s stks, from (:from moves), to (:to moves), i (:n moves)]
    (if (= i 0)
      s                              ;Return new stacks.
      (let [item (first (get s from))]
        (recur (assoc (assoc s from (rest (get s from)))
                      to (cons item (get s to))) from to (dec i))))))

;; Input: movement line from input, returns integer value hashmap with keys :n, :from, and :to.
(defn parse-move [line]
  "Convert an input line to an integer-valued hashmap with the number of moves, and the from and to stacks."
  (let [v (re-find #"move (\d+) from (\d+) to (\d+)" line)]
    {:n (Integer/parseInt (get v 1)) :from (Integer/parseInt (get v 2)) :to (Integer/parseInt (get v 3))}))

(defn -main
  "Advent of Code 2022 Day 5. Result is \"TDCHVHJTG\""
  [& args]
  (with-open [rdr (clojure.java.io/reader "../input")]
    (->> (line-seq rdr)                 ;File lines as lazy sequence.
         (drop 10)                      ;Skip the first 10 lines.
         (map parse-move)               ;Convert the lines to hashmaps.
         (reduce move-items stacks)     ;The workhorse: move items from stack to stack.
         (map first)                    ;The stacks are lists; we are only interested in the first elements.
         (drop 1)                       ;Skip the dummy first element (stack indices are 1-based).
         (reduce str ""))))             ;Concatenate the vector of single character strings to one string.
