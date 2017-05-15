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

; Check if a queue is empty
(defun queue-empty(queue)
	(return-from queue-empty (eq (length queue) 0) ))

; Get the last element in a list
(defun last-list-element(l)
	(return-from last-list-element (nth (- (length l) 1) l)))

; Perform a breadth-first search for 'goal' starting at 'start'
(defun bfs(start goal)
  	; Initialize some local data structures
  	(setq visited '())
  	(setq queue '())
  	(setq found nil)

	; Push the first vertex on the queue.
	(push (list start) queue)

	(loop
	  ; Pop the next processing path off of the queue
	  (setq path (first queue))
	  (setf queue (cdr queue))

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
			; Extend the frontier by pushing a new path on the queue.
			(setq queue
				  (append queue
						  (list (append path (list neighbor)))))

			; Mark this vertex as visited
			(push neighbor visited)
			)))

	  ; Return as soon as the loop is empty
	  (when (eq (queue-empty queue) t) (return nil)))

	(return-from bfs found))

; Endless loop prompting the user to search for values in the graph above
(loop
  	(format t "Select a state to search for: ")
	(setq goal (read))

	(setq path (bfs 1 goal))

	(if (not (eq path nil))
	  (format t "Found ~a in path ~a ~%" goal path)
	  (format t "Sorry, couldn't find ~a~%" goal))
  )
