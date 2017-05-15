(setq *print-case* :capitalize)

(setq superheroes '(superman batman aquaman flash joker))

(format t "First element in the list: ~d ~%" (nth 0 superheroes))

(format t "Second element in the list: ~d ~%" (nth 1 superheroes))

(format t "Third element in the list: ~d ~%" (nth 2 superheroes))

(print "What superhero are you adding to the list?: ")
(push (read) superheroes)

(print "What superhero are you looking for?: ")
(setq search (read))

(print (if (member search superheroes) 't nil))
