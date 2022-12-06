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

;; Move N item substack from stack FROM tp stack TO. Return the stacks vector.
(defn move-items [stks moves]
  "Move n items from one stack to another, keeping the order."
  ;; move (:n moves) elements from stack (:from moves) to (:to moves).
  (let [tolist (get stks (:to moves)), fromlist (get stks (:from moves)),
        newto (reduce (fn [lst elem] (cons elem lst)) tolist (reverse (take (:n moves) fromlist))),
        newfrom (drop (:n moves) fromlist)]
    (assoc (assoc stks (:to moves) newto) (:from moves) newfrom)))

;; Input: movement line from input, returns integer value hashmap with keys :n, :from, and :to.
(defn parse-move [line]
  "Convert an input line to an integer-valued hashmap with the number of moves, and the from and to stacks."
  (let [v (re-find #"move (\d+) from (\d+) to (\d+)" line)]
    {:n (Integer/parseInt (get v 1)) :from (Integer/parseInt (get v 2)) :to (Integer/parseInt (get v 3))}))

(defn -main
  "Advent of Code 2022 Day 5. Result is \"NGCMPJLHV\""
  [& args]
  (with-open [rdr (clojure.java.io/reader "../input")]
    (->> (line-seq rdr)
         (drop 10)
         (map parse-move)
         (reduce move-items stacks)
         (map first)
         (drop 1)
         (reduce str ""))))
