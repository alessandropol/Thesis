;   				 MATCH		        						 REWRITE									RULE NAME

(setq rules
	'(
		( 		(not (not ?x))							    ?x 						    					"not not ?x")
		
		( 		(not (-> ?x ?y))							(or (not ?x) ?y)								"not ->" )
		
		( 		(not (> ?x ?y))							    (<= ?x ?y)					    				"not major" )
		
		( 		(not (< ?x ?y))								(>= ?x ?y) 					    				"not minor" )
		
		( 		(not (= ?x ?y))								(!= ?x ?y)				   	 					"not Equality" )
        
		( 		(not (!= ?x ?y))							(= ?x ?y) 				    					"not Inequality" )
		
		( 		(not (and ?x ?y))					        (or (not ?x) (not ?y))							"multi de morgan and" )		
		
		( 		(not (and ?x *m))					        (or (not (and *m))(not ?x))						"de morgan and" )		

		(		(not (or ?x ?y))		    				(and (not ?x) (not ?y)) 			    		"de morgan or" )		
		
		( 		(not (or ?x *m))					        (and (not (or *m))(not ?x))						"multi de morgan or" )		

		(	    (and *h (and *m ) *t)  						(and *h *m *t)									"flat And" )
		
		(	    (or *h (or *m ) *t)  						(or *h *m *t)									"flat Or" )
		
		(	    (+ *h (+ *m ) *t)  						    (+ *h *m *t)									"flat +" )
		   
		(       (+ *h + *m)									(+ *h *m) 										"red. flat +")

		(	    (- *h (- *m ) *t)  						    (- *h *m *t)									"flat -" )
		
		(       (- *h - *m)									(- *h *m) 										"red. flat -")
	)
)