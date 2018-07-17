;file contenente le funzioni che implementano il dimostratore di teoremi mediante la tecnica del tableau semantico per PREDICATI

(load "production_rule_system.lsp")
(load "predicative_rules.lsp")

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
		( (isComplementary tree) (print '|------------------------- T  A  U  T  O  L  O  G  I  A ------------------------- |))
		(t (let
				( 
					(TreeExt (exploreTree tree)) 
				)
				(cond
					( (equal tree TreeExt)
						(cond
							((not (null (findPredicate tree))) (tableau_loop (applyPredicate tree (findPredicate tree)) ))
							(t  (print "<<<< THE ELABORATION WAS STOPPED"))
						)
					)
					( t (tableau_loop TreeExt))
				)
			)
		)
	)
)	

(defun findPredicate (tree)
	(let
		( 
			(bestRule (lookforRule tree nil '$))
		)
		(cond
			( (null bestRule) nil)
			( (> (parse-integer (car bestRule)) 1) nil)
			( t bestRule)
		)				
	)
)

(defun lookforRule (tree rule level)
	(cond
		( (null tree) rule)
		( (and (stringp (caar tree)) (eq level '$)) (lookforRule (cdr tree) (car tree) (parse-integer (caar tree)) ) )
		( (and (stringp (caar tree)) (<= (parse-integer (caar tree)) level )) (lookforRule (cdr tree) (car tree) (parse-integer (caar tree)) ) )
		( (not (atom(caar tree)))
			(let
				(
					(bestRuleSX (lookforRule (caar tree) rule level))
					(bestRuleDX (lookforRule (cadar tree) rule level))
				)
				(cond
					( (and (null bestRuleSX) (null bestRuleDX)) rule)
					( (and (null bestRuleSX) (not (null bestRuleDX)))
						(cond 
							( (eq level '$) bestRuleDX)
							( (<= (parse-integer (car bestRuleDX)) level) bestRuleDX)
							(t rule)
						)
					)
					( (and (null bestRuleDX) (not (null bestRuleSX)))
					    (cond
							( (<= (parse-integer (car bestRuleSX)) level) bestRuleSX)
							( (eq level '$) bestRuleSX)
							(t rule)
						)
					)
					( (eq level '$)
						(cond
							( (<= (parse-integer (car bestRuleSX)) (parse-integer (car bestRuleDX))) bestRuleSX )
							( t bestRuleDX )
						)
					)
					( (and (<= (parse-integer (car bestRuleSX)) level) (and (<= (parse-integer (car bestRuleSX)) (parse-integer (car bestRuleDX))))) bestRuleSX  )
					( (and (<= (parse-integer (car bestRuleDX)) level) (and (<= (parse-integer (car bestRuleDX)) (parse-integer (car bestRuleSX))))) bestRuleDX  )
					(t rule)
				)
			)
		)
		( t (lookforRule (cdr tree) rule level))
	)
)

(defun applyPredicate (tree bestRule)
	(cond 
		( (null tree) nil)
		( (equal (car tree) bestRule) (cons (list (write-to-string (+ (parse-integer (car bestRule)) 1)) (cadr bestRule))  (extendTree (cdr tree) (cadr (applyRule (cadr bestRule) (findRule (cadr bestRule) rules))))))
		( (not (atom(caar tree)))  (list (list (applyPredicate (caar tree) bestRule) (applyPredicate (cadar tree) bestRule))))
		( t (cons (car tree) (applyPredicate (cdr tree) bestRule) ))
	)
)

(defun exploreTree (tree)
	(cond
		( (null tree) nil)
		( (stringp (car tree) ) tree)
		( (not (null (findRule (car tree) rules)))	(extendTree (cdr tree) (applyRule (car tree) (findRule (car tree) rules))))
		( (and (atom (car tree)) (atom (cadr tree))) tree )
		( (and (eq (car tree) 'not) (and (atom (caadr tree)) (atom (cadadr tree)))) tree)
		( t (cons (exploreTree (car tree)) (exploreTree(cdr tree))))
	)
)

(defun extendTree (tree result)
	(cond
		( (null tree)
			(cond 
				( (atom (car result)) (list result) )
				( t result)
			)
		)
		( (not (atom(caar tree)))  (list (list (extendTree (caar tree) result) (extendTree (cadar tree) result)))) ;( (not (atom(caar tree)))  (list (extendTree (caar tree) result) (extendTree (cadar tree) result)))
		(t (cons (car tree) (extendTree (cdr tree) result)) )
	)
)

(defun applyRule (exp ruleline)
	(print 'rule-)
	(prin1  (caddr ruleline))
	(cond
		( (or (equal (car ruleline)'(not (all ?x ?c))) (equal (car ruleline) '(exist ?x ?c)) (equal (car ruleline) '(all ?x ?c)) (equal (car ruleline)'(not (exist ?x ?c))))
			(let
				(
					(ruleRes (tryMatch exp ruleline))
				)
				(cond
						( (equal (car ruleline) '(not (all ?x ?c))) (rewrite (list 'not (list 'all (cdadr ruleRes) (developPre (cdar ruleRes) (cdadr ruleRes) 'a))) ruleline))
						( (equal (car ruleline) '(exist ?x ?c)) (rewrite (list 'exist (cdadr ruleRes) (developPre (cdar ruleRes) (cdadr ruleRes) 'a)) ruleline)) 
						( (equal (car ruleline) '(all ?x ?c))  (list (list "0" exp) (rewrite (list 'all (cdadr ruleRes) (developPre (cdar ruleRes) (cdadr ruleRes) 'a)) ruleline))) 
					    ( (equal (car ruleline) '(not (exist ?x ?c)))  (list (list "0" exp) (rewrite (list 'not (list 'exist (cdadr ruleRes) (developPre (cdar ruleRes) (cdadr ruleRes) 'a))) ruleline))) 
				)
			)
		)
		(t (rewrite exp ruleline))
	)
)
		
(defun developPre (exp var subvar)
	(cond
		( (null exp) nil)
		( (eq (cadr exp) var) (cons  (car exp) (cons  subvar nil)))
		( (atom (car exp)) (cons (car exp) (developPre (cdr exp) var subvar)))
		( (eq (cadar exp) var) (cons (list (caar exp) subvar) (developPre (cdr exp) var subvar)))
		( (not (atom (car exp))) (cons (developPre (car exp) var subvar) (developPre (cdr exp) var subvar)))
		(t (cons (car exp) (developPre (cdr exp) var subvar)))
	)
)	
				
(defun isComplementary (tree)
		(isComplementary_explore tree () ())
)


(defun isComplementary_explore (tree var NOTvar)
	(cond
		( (null tree) (or (isComplementary_find var NOTvar) (isComplementary_find NOTvar var)))
		( (and (atom (caar tree)) (atom (cadar tree))) (isComplementary_explore (cdr tree) (append var (list (car tree))) NOTvar))
		( (and (eq (caar tree) 'not) (and (atom (caadar tree)) (atom (car (cdadar tree))))) (isComplementary_explore (cdr tree) var (append NOTvar (list (cadar tree)))))
		( (not (atom(caar tree))) 	(and (isComplementary_explore(caar tree) var NOTvar) (isComplementary_explore(cadar tree) var NOTvar)))
		(t (isComplementary_explore (cdr tree) var NOTvar  ))
	)
)

(defun isComplementary_find (var1 var2)
	(cond 
		( (null var1) nil)
		( (searchLL (car var1) var2) t)
		(t (isComplementary_find (cdr var1) var2))
	)
)

(defun searchLL (ele lis)
	(cond
		( (null lis) nil)
		( (equal ele (car lis)) t)
		( t (searchLL ele (cdr lis)))
	)
)