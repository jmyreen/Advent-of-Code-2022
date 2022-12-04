(require 'stream)
(require 'seq)

;; Create a stream of buffer lines from point to the end of the buffer.
(defun lines-as-stream ()
  (if (eobp)
      (stream-empty)
    (stream-cons (thing-at-point 'line t) (progn
                                            (forward-line 1)
                                            (lines-as-stream)))))

;; Split string s in half, look for the common character in the
;; substrings. Map the characters to numbers as follows: a..z ->
;; 1..26, A..Z -> 27..52. This function assumes the input is correct;
;; it blows up if the string is of odd length, or if no common
;; character can be found. Note: s includes a newline at the end.
;; Integer division takes care of this.
(defun common-char-value (s)
  (let* ((half-length (/ (length s) 2))
	 (first (substring s 0 half-length))
	 (second (substring s half-length -1)) ;Skip newline at end with -1.
	 (common-char (seq-find (lambda (c) (seq-contains-p second c)) first)))
    (if (>= common-char ?a)
	(- common-char 96)
      (- common-char 38))))

;; Convert the sequence of lines to a sequence of numeric values with the
;; function common-char-value. Sum the values using seq-reduce.
(defun rucksack ()
  (seq-reduce #'+ (seq-map #'common-char-value (lines-as-stream)) 0))
