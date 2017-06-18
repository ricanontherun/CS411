(setq *board-size* 8)

; Build the board, all positions are initialized to zero.
(setq *board* '((0 0 0 0 0 0 0 0)
	  (0 0 0 0 0 0 0 0)
	  (0 0 0 0 0 0 0 0)
	  (0 0 0 0 0 0 0 0)
	  (0 0 0 0 0 0 0 0)
	  (0 0 0 0 0 0 0 0)
	  (0 0 0 0 0 0 0 0)
	  (0 0 0 0 0 0 0 0)))

(defun safe(row col)
  ; Check this row, right to left.
  ; As soon as we find a queen, we return nil.
  (loop for i from 0 upto (- col 1)
	do (if (eq (nth i (nth row *board*)) 1)
	  (return-from safe nil)))

  ; Check the diagonal moving toward (0,0)
  (loop
	for i from (- row 1) downto 0
	for j from (- col 1) downto 0
	do (if (eq (nth j (nth i *board*)) 1)
	  (return-from safe nil)))

  ; Check the diagonal moving toward (0,N)
  (loop
	for i from 0 upto (- row 1)
	for j from (- col 1) downto 0
	do (if (eq (nth j (nth i *board*)) 1)
	  (return-from safe nil)))

  ; All constraints have been satisfied, return true.
  (return-from safe t))

(defun solve(col)
  ; Base case
  (if (>= col *board-size*)
	(return-from solve t))

  (loop for i from 0 to (- *board-size* 1)
	do (progn
		(if (eq (safe i col) t)
		  (progn
			; Set the queen to this position
			(setf (nth col (nth i *board*)) 1)

		 	(if (eq (solve (+ col 1)) t)
				(return-from solve t))))

		 ; BACKTRACK
		 (setf (nth col (nth i *board*)) 0)

		 ; Default
		 (return-from solve nil)))
  )

(if (eq (solve 0) nil)
  (progn
	(print "No solution exists")))

(dolist (row *board*)
  (print row))
