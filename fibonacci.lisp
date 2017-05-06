; Week 2 Assignment - Fibonnaci Series 

(defun fib(n)
  "Return the series for a given n"
  (return-from fib (case n
	; Base cases of 0 and 1
	((0 1) 1)

	; Eveything else, aka recursive case
	(otherwise ( + (fib(- n 1)) (fib(- n 2)) ))
	))
)

(print (fib 5))
