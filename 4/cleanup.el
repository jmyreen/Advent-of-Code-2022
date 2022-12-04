(require 'stream)
(require 'seq)

;; Create a stream of buffer lines from point to the end of the buffer.
(defun lines-as-stream ()
  (if (eobp)
      (stream-empty)
    (stream-cons (thing-at-point 'line t) (progn
                                            (forward-line 1)
                                            (lines-as-stream)))))

;; Input: file row, output: t if ranges overlap, nil if not.
(defun full-overlap (row)
  (if (not (string-match "\\([0-9]+\\)-\\([0-9]+\\),\\([0-9]+\\)-\\([0-9]+\\)" row))
      (error "Wrong input.")
    (let ((lmin (string-to-number (match-string 1 row)))
	  (lmax (string-to-number (match-string 2 row)))
	  (rmin (string-to-number (match-string 3 row)))
	  (rmax (string-to-number (match-string 4 row))))
      (or
       (and (<= lmin rmin) (>= lmax rmax))
       (and (<= rmin lmin) (>= rmax lmax))))))

(defun cleanup ()
  (seq-count (lambda (x) x) (seq-map #'full-overlap (lines-as-stream))))
