;file contenente le funzioni per il sistema di produzione
(load "match.lsp")


(defun findRule (exp rules)
	(cond
		( (null rules) nil)
		( (not (eq (tryMatch exp (car rules)) ':failed)) (rewrite exp (car rules)))
		(t (findRule exp (cdr rules))) 
	)
)
																			
(defun tryMatch (exp ruleLine)
	(match (car ruleLine) exp)
)


(defun rewrite (exp ruleLine)
	(let ( (result (match (car ruleLine) exp))) 
		 (substituteSyimbol (cadr ruleLine) result) 
	)
)

(defun substituteSyimbol (rulerewrite result)
	(cond 
		( (null rulerewrite) nil ) 
		( (and (atom rulerewrite) (string= (string rulerewrite) "?" :start1 0 :end1 1))  (getSyimbol rulerewrite result))
		( (not (atom (car rulerewrite))) (cons (substituteSyimbol (car rulerewrite) result) (substituteSyimbol (cdr rulerewrite) result)))
		( (string= (string (car rulerewrite)) "?" :start1 0 :end1 1)  (cons (getSyimbol (car rulerewrite) result) (substituteSyimbol (cdr rulerewrite) result)))
		( (string= (string (car rulerewrite)) "*" :start1 0 :end1 1)
			(let ( (seq (getSequence (car rulerewrite) result)) )
				(cond 
					( (null seq) (substituteSyimbol (cdr rulerewrite) result) )  		 
					( t	(append seq (substituteSyimbol (cdr rulerewrite) result)))
				)
			)
		)
		( t (cons (car rulerewrite) (substituteSyimbol (cdr rulerewrite) result))) ;se non contiene una variabile ricopia l'atomo
	)
)
		

(defun getSyimbol (var result)
	(cond
		( (null result) nil )
		( (eq (caar result) var) (cdar result))
		( t (getSyimbol var (cdr result)))
	)
)

(defun getSequence (jolly result)
	(cond
		( (null result) nil )
		( (eq (caar result) jolly) 
			(cond 
				( (> (length (subseq (car result) 1))0) (subseq (car result) 1) )
				( t nil)
			)
		)
		( t (getSequence jolly (cdr result)))
	)
)
