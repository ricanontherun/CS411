; Week 3 - Depth-first search
; Prefilled adjacency list
(defvar *graph* '(
	(1 (2 3))
	(2 (15))
	(15 (20))
	(3 (100))
	))

; Get the neighbors (adjacent vertices) to a vertex in the graph
(defun get-neighbors(index)
	(return-from get-neighbors (cadr (assoc index *graph*))))

; Check if a particular vertex has been visited
(defun vertex-visited(visited vertex)
	(return-from vertex-visited
		(not (eq (member vertex visited) nil))))

; Check if a stack is empty
(defun list-empty(list)
	(return-from list-empty (eq (length list) 0) ))

; Get the last element in a list
(defun last-list-element(l)
	(return-from last-list-element (nth (- (length l) 1) l)))

; Perform a breadth-first search for 'goal' starting at 'start'
(defun dfs(start goal)
  	; Initialize some local data structures
  	(setq visited '())
  	(setq stack '())
  	(setq found nil)

	; Push the first vertex on the stack.
	(push (list start) stack)

	(loop
	  ; Pop the next processing path off of the stack
	  (setq path (first stack))
	  (setf stack (cdr stack))

	  ; Get the last vertex in that path, we'll extend the frontier with this.
	  (setq vertex (last-list-element path))

	  ; As soon as we find our goal state/node, break.
	  (if (eq vertex goal)
		(progn
		  (setq found path)
		  (return)))

	  (setq neighbors (get-neighbors vertex))

	  ; Loop over each neighbor
	  (dolist (neighbor (get-neighbors vertex))
		; if this neighbor hasn't already been visited
		(if (eq (vertex-visited visited neighbor) nil)
		  (progn
			; Extend the frontier by pushing a new path on the stack.
			(push (append path (list neighbor)) stack);

			; Mark this vertex as visited
			(push neighbor visited)
			)))

	  ; Return as soon as the loop is empty
	  (when (eq (list-empty stack) t) (return nil)))

	(return-from dfs found))

; Endless loop prompting the user to search for values in the graph above
(loop
  	(format t "Select a state to search for: ")
	(setq goal (read))

	(setq path (dfs 1 goal))

	(if (not (eq path nil))
	  (format t "Found ~a in path ~a ~%" goal path)
	  (format t "Sorry, couldn't find ~a~%" goal))
  )
