; Define a struct 'point' which contains two members, x and y
(defstruct point x y)

; Make a list of point structs, this is our data set.
(setq *points* (list
	(make-point :x 10 :y 2)
	(make-point :x 20 :y 200)))

; Calculate the mean of a list of values
; Returns either the mean of the values, or -1 on error.
(defun mean(values)
  (setq num (length values))
  (setq value 0)

  (if (eq num 0)
	(return-from mean -1))

  (dolist (v values)
	(setq value (+ value v)))

  (return-from mean (/ value num)))

; Calculate the variance of a set of values.
; Returns either the variance of the values, or -1 on error.
(defun variance (values)
  (if (eq (length values) 0)
	(return-from variance -1))

  (setq mean (mean values))
  (setq squared_differences ())

  ; Push the square of each difference on a list
  (dolist (v values)
	(push (expt (- mean v) 2) squared_differences))

  ; Return the mean of those squared differences 
  (return-from variance (mean squared_differences)))

; Calculate the covariance for a set of points
; Returns the covariance or -1 on error
(defun covariance(points)
  	(setq num_points (length points))

	; We need at least two points to calculate covariance.
  	(if (< num_points 2)
	  (return-from covariance -1))

	; Extract the x values from the points
	(setq x_data ())

	(dolist (point *points*)
	  (push (point-x point) x_data))

	; Extract the y values from the points
	(setq y_data ())

	(dolist (point *points*)
	  (push (point-y point) y_data))
	
	(setq x_mean (mean x_data))
	(setq y_mean (mean y_data))
	(setq sum 0)
	
	(dolist (point points)
	  (setq sum (+ sum
		(* (- (point-x point) x_mean) (- (point-y point) y_mean))
		)))
	
	(return-from covariance (/ sum num_points)))

(format t "Covariance of ~d is ~f ~%" *points* (covariance *points*))
