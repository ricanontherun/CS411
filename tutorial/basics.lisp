; Single line comments.
#||
Multi line comment
||#

(print "What's your name?")

; Declare a global variable called name which reads from the terminal.
; The ** characters aren't needed, but they help denote a global variable the way UPPERCASE
; is used to denote constants.
(defvar *name* (read))

; Define a function which takes an argument of arg and prints it to the screen.
(defun hello-you (name major)
	(format t "Hello ~a!, good luck studying ~b! ~%" name major)
)

; *print-case* is a global system variable.
(setq *print-case* :capitalize)

; Call the function
(hello-you *name* "Computer Science")

(hello-you *name* "Music Education")

; Print some math
(format t "5 + 4 = ~d ~%" (+ 5 4))

(format t "(eq *name* 'Derek) ~d ~%" (eq *name* 'Derek))

(setq access-level 0)

(print "Please login")
(print "Username: ")

(defvar *username* (read))

(print "Password")
(defvar *password* (read))

(defvar *admin_username* 'ricanontherun)
(defvar *admin_password* 'apassword)

(if (and (eq *username* *admin_username*) (eq *password* *admin_password*))
	(progn
	 	(setq access-level 2)
		(print "welcome admin!"))
	(progn
	 (setq access-level 1)
	(print "welcome user"))
  )

(format t "Your access level: ~d ~%" access-level)

(case access-level
	(1 (print "You have basic access"))
	(2 (print "You're an admin and have full access"))
 	(otherwise (print "You have no access"))
  )

(cond ((= access-level 2)
	  	(print "yeo")
		(print "you're an admin"))
	 ((= access-level 1)
	 	(print "hello")
		(print "you have basic access man"))
	  )
