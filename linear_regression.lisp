; Define a struct 'point' which contains two members, x and y
(defstruct point x y)

; Make a list of point structs, this is our data set.
(setq *points* (list
	(make-point :x 1 :y 2)
	(make-point :x 100 :y 200)))

; Calculate the mean of a list of values
(defun mean(values)
  (setq num (length values))
  (setq value 0)

  (if (eq num 0)
	(return-from mean -1))

  (dolist (v values)
	(setq value (+ value v)))

  (return-from mean (/ value num)))

; Calculate the variance of a set of values.
; The variance is the mean of the squared differences from the mean.
(defun variance (values)
  (if (eq (length values) 0)
	(return-from variance -1))

  (setq mean (mean values))
  (setq differences ())

  (dolist (v values)
	(push (expt (- mean v) 2) differences))

  (return-from variance (mean differences)))

(setq data (list 10 20 30))

(format t "The mean of ~d is ~d ~%" data (mean data))
(format t "The variance of ~d is ~f ~%" data (variance data))
