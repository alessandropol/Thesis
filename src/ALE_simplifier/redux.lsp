(load "rules.lsp")
(load "production_rule_system.lsp")

(defun redux (exp)
	(print exp)
	(let
		( 
			(semp (explore exp)) 
		)
		(cond
			( (or (atom semp) (equal exp semp)) semp )
			( t (redux semp))
		)
	)
)

(defun explore (exp)
	(cond
		( (null exp)  exp) 
		( (atom (car exp)) (semplify (cons (car exp) (explore (cdr exp)))) )   
		( t (semplify (cons (explore (car exp)) (explore (cdr exp)))))         
	)
)

(defun semplify (exp)
		(let 
			(
			   (matchrule (findRule exp rules))
			)
			(cond
				( (null matchrule) exp)
				( t matchrule)
			)
		)
)

