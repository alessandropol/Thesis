;file contenente le funzioni che implementano il dimostratore di teoremi mediante la tecnica del tableau semantico per PROPOSIZIONI

(load "propositional_rules.lsp")
(load "production_rule_system.lsp")

(defun tableau (exp)
	(print 'RUNNING>>)
	(format t "~%")
	(tableau_loop (list (list 'not exp)))
	(format t "~%")
	(print '>>complete)
	(format t "~%")
)

(defun tableau_loop (tree)
	(cond
		( (isComplementary tree) (print '|------------------------- T  A  U  T  O  L  O  G  I  A -------------------------|))
		(t (let
			( 
				(TreeExt (exploreTree tree)) 
			)
			(cond
				( (equal tree TreeExt) (findNegation tree) )
				( t (tableau_loop TreeExt))
			))
		)
	)
)	


(defun exploreTree (tree)
	(cond
		( (null tree) nil)
		( (not (null (findRule (car tree) rules)))	(extendTree (cdr tree) (applyRule (car tree) (findRule (car tree) rules))))
		( (atom (car tree)) (cons (car tree) (exploreTree (cdr tree)) ))
		( (not (atom(caar tree))) (list (list (exploreTree (caar tree)) (exploreTree(cadar tree)))))
		( t (cons (car tree) (exploreTree (cdr tree)) ))
	)
)

(defun extendTree (tree result)
	(cond
		( (null tree) result )
		( (atom (car tree)) (cons (car tree) (extendTree (cdr tree) result)))
		( (not (atom(caar tree))) (list (list (extendTree (caar tree) result) (extendTree (cadar tree) result))))
		(t (cons (car tree) (extendTree (cdr tree) result)))
	)
)

(defun applyRule (exp ruleline)
	(print 'rule-)
	(prin1  (caddr ruleline))
	(rewrite exp ruleline)
)
		
(defun isComplementary (tree)
		(isComplementary_explore tree () ())
)


(defun isComplementary_explore (tree var NOTvar)
	(cond
		( (null tree) (or (isComplementary_find var NOTvar) (isComplementary_find NOTvar var)))
		( (atom (car tree)) 		(isComplementary_explore (cdr tree) (append var (list (car tree))) NOTvar))
		( (eq (caar tree) 'not) 	(isComplementary_explore (cdr tree) var (append NOTvar (list (cadar tree)))))
		( (not (atom(caar tree))) 	(and (isComplementary_explore(caar tree) var NOTvar) (isComplementary_explore(cadar tree) var NOTvar)))
		(t nil)
	)
)

(defun isComplementary_find (var1 var2)
	(cond 
		( (null var1) nil)
		( (not (null (find (car var1) var2))) t)
		(t (isComplementary_find (cdr var1) var2))
	)
)


(defun findNegation_explore (tree var NOTvar)
	(cond
		( (null tree)
			(cond 
				( (or (isComplementary_find var NOTvar) (isComplementary_find NOTvar var)) t) 
				(t (printNegation var NOTvar))
			)
		)
		( (atom (car tree)) 		(findNegation_explore (cdr tree) (append var (list (car tree))) NOTvar))
		( (eq (caar tree) 'not) 	(findNegation_explore (cdr tree) var (append NOTvar (list (cadar tree)))))
		( (not (atom(caar tree))) 	(and (findNegation_explore(caar tree) var NOTvar) (findNegation_explore(cadar tree) var NOTvar)))
		(t nil)
	)
)

(defun findNegation (tree)
	(format t "~%")
	(print '|----------------------------- O P I N I O N E ------------------------------| )
	(print '|espressione falsa per:|)
	(format t "~%")
	(findNegation_explore tree () ())
	(format t "~%")
)

(defun printNegation (var NOTvar)
	(cond
         ( (null var) (print (append (remove-duplicates NOTvar) (list '=0))))
		( (null NOTvar) (print (append (remove-duplicates var) (list '=1))))
		( (and (null var) (null NOTvar)) (print "  "))
		( t (print (append (remove-duplicates NOTvar) (list '=0) (list '&) (remove-duplicates var) (list '=1))))
	)
)
