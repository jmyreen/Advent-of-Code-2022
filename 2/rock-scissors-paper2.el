;; A,X = Rock, 1 point
;; B,Y = Paper, 2 points
;; C,Z = Scissors, 3 points
;; Loss = 0, Draw = 3, Win = 6

;; X = Lose
;; Y = Draw
;; Z = Win

(setq al '(("A X" 3)			;Lose against Rock: Scissors (3 pts)
	   ("A Y" 4)			;Draw (3 pts) against Rock (1 pt)
	   ("A Z" 8)			;Win (6 pts) against Rock: Paper (2 pts)
	   ("B X" 1)			;Lose against Paper: Rock (1 pt)
	   ("B Y" 5)			;Draw (3 pts) against Paper (2 pts)
	   ("B Z" 9)			;Win (6 pts) against Paper: Scissors (3 pts) 
	   ("C X" 2)			;Lose against Scissors: Paper (2 pts)
	   ("C Y" 6)			;Draw (3 pts) against Scissors (3 pts)
	   ("C Z" 7)))			;Win (6 pts) against Scissors: Rock (1 pt)

(defun rock-scissors-paper-2 (score)
  (if (eobp)
      score
    (let ((n (cadr (assoc (buffer-substring-no-properties (pos-bol) (pos-eol)) al))))
      (forward-line)
      (rock-scissors-paper (+ n score)))))
