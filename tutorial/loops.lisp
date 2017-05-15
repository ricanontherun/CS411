; Basic range loop
(loop for x from 1 to 10
	  do (print x))

(setq x 1)
(loop
 	(print x)
	(setq x (+ x 1))
	(when (> x 10) (return x))
  )

(setq *print-case* :capitalize)
(loop for name in '(Peter Paul Mary)
	  do (print name))

(setq email-count 12)
(dotimes (y email-count)
  (format t "Sending email #~d ~%" y)
  )
