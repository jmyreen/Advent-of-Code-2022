(defun lines-sum ()
  (if (looking-at "^\\([0-9]+\\)")
      (+ (string-to-number (match-string 1))
	 (progn
	   (forward-line)
	   (lines-sum)))
    0))

(defun max-calories (max-so-far)
  (if (eobp)
      max-so-far			;If end of input return max-so-far
    (let ((sum (lines-sum)))
      (forward-line)
      (max-calories (max max-so-far sum)))))
