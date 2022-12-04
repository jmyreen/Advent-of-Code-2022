;; Calculate the sum of lines beginning with a number. If the line
;; does not contain a number, return 0.
(defun lines-sum ()
  (if (looking-at "^\\([0-9]+\\)")
      (+ (string-to-number (match-string 1))
	 (progn
	   (forward-line)
	   (lines-sum)))
    0))

;; Given a list of numbers and a the number n, return a new list with
;; the first occurrence of a number in the list which is smaller than
;; n replaced with n. If no number in the list is smaller than n,
;; return the original list.
(defun max-list (lst n)
  (when (not (null lst))
    (if (> n (car lst))
	(cons n (cdr lst))
      (cons (car lst) (max-list (cdr lst) n)))))

;; The input files consist of lines starting with a number. The
;; numbers are in groups separated by empty lines. This function
;; calculates the sum of the groups and returns the sum of the (length
;; lst) number of group sums.
(defun maxn-calories (lst n)
  (if (eobp)
      (apply '+ lst)
    (let ((sum (lines-sum)))
      (forward-line)
      (maxn-calories (max-list lst sum) n))))
