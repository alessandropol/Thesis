;					RULE						REWRITE								NAME					

(setq rules
	'(		
		(		(not (not ?a))					  (?a) 					   			"(NOT (NOT A))"    )
			
		(		(and ?a1 ?a2)					  ( ?a1 ?a2 )						"(A1 & A2)"		   )
			
		(		(not (or ?a1 ?a2))				  ( (not ?a1) (not ?a2) ) 			"(NOT (A1 OR A2))" )
		
		(		(not (-> ?a1 ?a2))		          (?a1 (not ?a2))					"(NOT ( A1 -> A2))")
		
	    
		
		(		(or ?b1 ?b2)					  (((?b1) (?b2))) 					"( B1  OR  B2)"     )
		
		( 		(not (and ?b1 ?b2))		      	  ((((not ?b1)) ((not ?b2))))				"NOT ( A AND B)"   )
		
		(		(-> ?b1 ?b2)				  	  (( ((not ?b1)) ( ?b2)))				"(NOT ( A -> B))"  )
		
	)
)

