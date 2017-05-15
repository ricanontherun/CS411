; Prefilled adjacency list
(defvar *graph* '(
	(1 (2 3))
	(2 (15 20))
	(3 (100))
))

(defun get-neighbors(index)
	(return-from get-neighbors (cadr (assoc index *graph*))))

(defun vertex-visited(visited vertex)
	(return-from vertex-visited
		(not (eq (member vertex visited) nil))))

(defun queue-empty(queue)
  (return-from queue-empty (eq (length queue) 0) ))

(defun bfs(start)
  	; Initialize some local data structures
  	(setq visited '())
	(setq queue '())

	; Push the first vertex on the queue.
	(push start queue)

	(loop
	  ; Get the next queue element
	  (setq vertex (first queue))
	  (format t "Processing vertex ~a ~%" vertex)

	  ; Pop that element off the list.
	  (setf queue (cdr queue))

	  (setq neighbors (get-neighbors vertex))

	  (format t "Vertex ~a has neighbors ~a ~%" vertex neighbors)

	  ; Loop over each neighbor
	  (dolist (neighbor (get-neighbors vertex))
		; if this neighbor hasn't already been visited
		(if (eq (vertex-visited visited neighbor) nil)
		  ; Mark it as visited and queue it up.
		  (progn
			(push neighbor visited)
			(push neighbor queue))))

	  ; Return as soon as the loop is empty
	  (when (eq (queue-empty queue) t) (return nil)))
	)

(bfs 1)
