; Coefficients, these are global so the prediction function can access them easily
(setq *b0* 0)
(setq *b1* 0)

; Calculate the mean of a list of values
; Returns either the mean of the values, or -1 on error.
(defun Mean(values)
  (setq num (length values))
  (setq value 0)

  (if (eq num 0)
	(return-from Mean -1))

  (dolist (v values)
	(setq value (+ value v)))

  (return-from Mean (/ value num)))

; Calculate the variance of a set of values.
; Returns either the variance of the values, or -1 on error.
(defun Variance (values)
  (if (eq (length values) 0)
	(return-from Variance -1))

  (setq mean (mean values))
  (setq squared_differences ())

  ; Push the square of each difference on a list
  (dolist (v values)
	(push (expt (- mean v) 2) squared_differences))

  ; Return the mean of those squared differences
  (return-from Variance (mean squared_differences)))

; Calculate the covariance for a set of data
; Returns the covariance or -1 on error
(defun Covariance(x y)
  	(setq len (length x))

	; We need at least two points to calculate Covariance.
  	(if (< len 2)
	  (return-from Covariance -1))

	(setq x_mean (mean x))
	(setq y_mean (mean y))
	(setq sum 0)

	(loop
	  for i from 0 to (- len 1)
	  do (setq sum (+ sum
		(* (- (nth i x) x_mean) (- (nth i y) y_mean))
		)))

	(return-from Covariance (/ sum len)))

; Calculate the coefficients
(defun CalculateCoefficients(x y)
  (setq covariance (Covariance x y))
  (setq variance (Variance x))
  (setq *b1* (/ covariance variance))

  (setq x_mean (Mean x))
  (setq y_mean (Mean y))

  (setq *b0* (- y_mean (* *b1* x_mean))))

; Given a bill amount, calculate the tip amount
(defun PredictTipAmount(bill)
	(return-from PredictTipAmount (+ *b0* (* *b1* bill))))

; TESTING SITUATION
; Given two data points, a bill total and the amount I tipped,
; train the model to predict how much I should tip next time.
(setq bills (list 10 20 30 40))
(setq tips (list 5 10 15 20))

(setq coefficients (CalculateCoefficients bills tips))

(format t "Using training data x:~d and y:~d, we can predice that a bill amount of ~d should yield a tip of ~d ~%" bills tips 100 (PredictTipAmount 100))
