
(defun Match(p s)
  
  (let((r (Match-h1 p s nil)))(if (or(eq r :failed)(Match-CheckDuplicatedJolly r)) :failed r))
)


(defun Match-h1(p s a)
	(cond
		
		((null p) (if (null s) a :failed))               
		
		
		((or (atom p)(atom s))
			(cond 
				((eq p s) a)                                   
				((Match-Varp p)                                
					(let((aa (assoc p a)))
						(cond						                  
							((null aa)(cons (cons p s) a))            
							((eq p (cdr aa)) a)                       
							(t :failed)                               
						)
					)
				) 
				((Match-Seqp p) (cons(cons p s)a))                        
				((and (not(atom p))(Match-Seqp (car p))(null (cdr p)))    
				(cons (cons (car p) s) a))
				((and (not(atom p))(Match-Seqp (car p))(equal (cdr p) s)) 
				(cons (cons (car p) nil) a))
				(t :failed)                                   
			)
	    )
  
		((equal (car p) (car s))    (Match-h1 (cdr p)(cdr s) a))                       
		
		((Match-Varp(car p))       	                    
			(let((aa (assoc (car p) a)))
				(cond     
					((null aa)(Match-h1 (cdr p)(cdr s) (cons(cons (car p) (car s)) a)))   
					((equal (cdr aa) (car s))(Match-h1 (cdr p)(cdr s) a))                 
					(t :failed)                                                           
				)
			)
		) 
	
        
		((and (Match-ConstrainedVar(car p))(Match-VerifyConstraint(car p)(car s)))
			(let((aa (assoc (caar p) a)))
				(cond  									                                 
					((null aa)(Match-h1 (cdr p)(cdr s) (cons(cons (caar p) (car s)) a))) 
					((equal (cdr aa) (car s))(Match-h1 (cdr p)(cdr s) a))                
					(t :failed)                                                          
				)
			)
		)  
		
		((Match-Seqp(car p))
			(let((r1 (Match-h1 (cdr p) s a))) 
				(if (not(eq r1 :failed))
					(cons (cons (car p) nil) r1)                   
					(let((r2 (Match-h1 (cdr p)(cdr s) a)))         
						(if (not(eq r2 :failed))
							(cons (cons (car p)(cons (car s) nil)) r2)    
							(let((r3 (Match-h1 p (cdr s) a)))             
								(if (not(eq r3 :failed))
									(Match-Extend (car p)(car s) r3)      
									:failed
								)
							)
						)
					)
				)
			)
		)   
		
		(t 
			(let((aa (Match-h1 (car p)(car s) a))) 
				(if (eq aa :failed)                
					:failed                        
					(Match-h1 (cdr p)(cdr s) aa)
				)      
			)
		) 
    )
)
  

(defun Match-Varp(x)(
	if (atom x)(string=(subseq (symbol-name x) 0 1) "?") nil)
)


(defun Match-Seqp(x)
	(if (atom x)(string=(subseq (symbol-name x) 0 1) "*") nil)
)


(defun Match-Extend(x v a)
	(let((r (assoc x a)))
		(progn (rplacd r (cons v (cdr r))) a))
)
    

(defun Match-ConstrainedVar(x)
	(and(not(atom x))(Match-Varp(car x))(consp (cdr x))(null (cddr x)))
)


(defun Match-VerifyConstraint(x s)
	(funcall (cadr x) s)
)


(defun Match-CheckDuplicatedJolly(a)
    (if (null a) 
     nil
        (let((r (car a)))
			(if (Match-Seqp (car r))
				(let ((aa(assoc (car r) (cdr a))))
					(if (or(null aa)(equal r aa))
						(Match-CheckDuplicatedJolly (cdr a)) 
						:failed
					)
				)
				(Match-CheckDuplicatedJolly(cdr a))             
			)
		)
	)
)
