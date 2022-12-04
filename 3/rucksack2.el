(require 'stream)
(require 'seq)

;; Create a stream of buffer lines from point to the end of the buffer.
(defun lines-as-stream ()
  (if (eobp)
      (stream-empty)
    (stream-cons (thing-at-point 'line t) (progn
                                            (forward-line 1)
                                            (lines-as-stream)))))

;; Parititon the sequence of lines to a sequence of subsequences, each
;; evaluating to three lines. Convert the three-line subsequences to a
;; group priority number with the function group-priority. Sum the
;; sequence of group priority values using seq-reduce.
(defun rucksack-2 ()
  (seq-reduce #'+ (seq-map #'group-priority (seq-partition (lines-as-stream) 3)) 0))

;; Calculate the Elf group priority. Input is a stream of three strings.
;; Look fpr the common character in the three strings and convert the
;; character to a number.
(defun group-priority (strm)
  (seq-let (s1 s2 s3) strm
    (let ((common-char (seq-find (lambda (c) (and (seq-contains-p s2 c) (seq-contains-p s3 c))) s1)))
      (if (>= common-char ?a)
	  (- common-char 96)
	(- common-char 38)))))
