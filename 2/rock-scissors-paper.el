;; A,X = Rock, 1 point
;; B,Y = Paper, 2 points
;; C,Z = Scissors, 3 points
;; Loss = 0, Draw = 3, Win = 6

(setq al '(("A X" 4)			;Rock 1 pt + draw 3 pts
	   ("A Y" 8)			;Paper 2 pts + win 6 pts
	   ("A Z" 3)			;Scissors 3 pts + loss 0 pts
	   ("B X" 1)			;Rock 1 pt + loss 0 pts
	   ("B Y" 5)			;Paper 2 pts + draw 3 pts
	   ("B Z" 9)			;Scissors 3 pts + win 6 pts
	   ("C X" 7)			;Rock 1 pt + win 6 pts
	   ("C Y" 2)			;Paper 2 pts + loss 0 pts
	   ("C Z" 6)))			;Scissors 3 pts + draw 3 pts

(defun rock-scissors-paper (score)
  (if (eobp)
      score
    (let ((n (cadr (assoc (buffer-substring-no-properties (pos-bol) (pos-eol)) al))))
      (forward-line)
      (rock-scissors-paper (+ n score)))))
