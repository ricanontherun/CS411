(setq *print-case* :capitalize)

(defun print-list (x y z)
  (format t "Arguments: ~a ~%" (list x y z)))

; THe print-list function but with optional NAMED arguments
(defun print-list-2 (&optional &key x y z)
  (format t "Arguments: ~a ~%" (list x y z)))

(print-list 1 2 3)

(defvar *total* 0)

; &rest turns the passed arguments into a list, named nums
(defun sum (&rest nums)
  	; dolist iterates over a list
	(dolist (num nums)
	  (setf *total* (+ *total* num)))
  )

(sum 1 2 3)

(format t "(sum 1 2 3) = ~a ~%" *total*)

(print-list-2 :y 1)
