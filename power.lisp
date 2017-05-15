; Week 2 Assignment - Exponential Function
(defun power (base exponent)
	"Find base^exponent"

	(setq result base)
	(setq iterations (- exponent 1))

	(loop for i from 1 to iterations do (
		setq result (* result base)
	))

	(return-from power result)
)

(print (power 3 3))

