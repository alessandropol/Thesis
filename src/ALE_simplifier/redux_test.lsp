(load "testsuite.cl")
(load "redux.lsp")


(test-suite "--- Negation normal form test suite ---"                                                                                                                                                               
                                                                                                                                                                                                                    
  (test (redux '(not(not a)))   																	          																										'a       			   	    								      					 																						"test01")
  (test (redux '(not(not(not(not(not(not a)))))))   												          																										'a       				    									  					     																					"test02")
  (test (redux '(and (not (not x))(or c d)))  											                      																										'(and x (or c d))               	    																																	"test03")
																																																																																																
  (test (redux '(not (and a b)))   															                  																										'(or (not a) (not b))       																																				"test04")
  (test (redux '(not (and (not a) (not b))))   													              																										'(or a b)       		    	    															    																		"test05")
  (test (redux '(not (and (not (not a)) (not (not b)))))   											          																										'(or (not a) (not b))       																	    																		"test06")
  (test (redux '((not (not a)) (not (and x y)) (not (not b))))									              																										'(a (or (not x) (not y)) b)       																																			"test07")
																																																																																																
  (test (redux '(not (or a b)))   															                  																										'(and (not a) (not b))       																	    																		"test08")
  (test (redux '(not (or (not a) (not b))))   													              																										'(and a b)       																																							"test09")
  (test (redux '(not (or (not (not a)) (not (not b)))))   											          																										'(and (not a) (not b))       																																				"test10")
  (test (redux '(and (not (not a)) (not (or x y)) (not (not b))))									              																									'(and a (not x) (not y) b)      																																			"test11")
																																																																																																
  (test (redux '(not (-> a b)))   														    	              																										'(or (not a) b)       		        																																		"test12")
  (test (redux '(and (not (-> a b)) (not (or c d))))								                          																										'(and (or (not a) b) (not c) (not d))  																																		"test13")
																																																																																                                                                
  (test (redux '(not (> a b)))   														    	              																										'(<= a b)       		         																																			"test14")
  (test (redux '(not (< a b)))   														    	              																										'(>= a b)       		         																																			"test15")
  (test (redux '(not (= a b)))   														    	              																										'(!= a b)       		         																																			"test16")
  (test (redux '(not (!= a b)))   														    	              																										'(= a b)       		         																																				"test17")
																																																																																						                                        
  (test (redux '(not (and p (not (and p (or (not (= b c)) s))))))						                      																										'(or (not p) (and p (or (!= b c) s)))   																																	"test18")
  (test (redux '(and (or (not (and a b)) (or a b)) (not (and (or a b) (or a b)))))                           																										'(and (or (not a) (not b) a b) (or (and (not a) (not b)) (and (not a) (not b))))              																				"test19")
  (test (redux '(not (and (or (not(not(!= a w))) (and (not(-> k o)) w)) (not (and (-> w s) (not (or a b)))))))  																									'(or (and (= a w) (or (and k (not o)) (not w))) (and w (not s) (not b) (not a)))																							"test20")
  (test (redux '(not (-> (or (< a b) (and r w)) (or (-> (< w q) (not (> u i))) (and (not (-> g f)) (or j h))) )))   																								'(or (and (>= a b) (or (not r) (not w))) (-> (< w q) (<= u i)) (and (or (not g) f) (or j h))) 																				"test21")
  (test (redux '(and (and (not (or a b)) (not (or b c)) (not (or c d))) (or (not (and e f)) (not (and g h)) (not (and i l)))))																						'(and (not a) (not b) (not b) (not c) (not c) (not d) (or (not e) (not f) (not g) (not h) (not i) (not l)))																	"test22")
  (test (redux '(and (and (not (or a b)) (not (-> (and i k) (or u b))) (or (not (or o l)) (or (-> o l) (< i k)))) (not (or(= a b) (and i k)))(not (-> (not(not a)) (!= b c))) (and w (or (not (-> a s)) (> n m))))) '(and (not a) (not b) (or (not i) (not k) u b)(or (and (not o) (not l))(-> o l) (< i k))(!= a b) (or (not i)(not k))(or (not a) (!= b c)) w (or (not a) s (> n m)))         "test23")

  (test (redux '(+ (+ 1 2 3) (+ 4 5 6) (+ 7 8 9)))							 																																		'(+ 1 2 3 4 5 6 7 8 9)	  																																					"test24")
  (test (redux '(+ 6 6 6 (+ 1 2 3) 6 6 6 (+ 4 5 6) 6 6 6 (+ 7 8 9)))							 																													'(+ 6 6 6 1 2 3 6 6 6 4 5 6 6 6 6 7 8 9)	  																																"test25")
  (test (redux '(- (- 1 2 3) (- 4 5 6) (- 7 8 9)))							 																																		'(- 1 2 3 4 5 6 7 8 9)	  																																					"test26")
  (test (redux '(- 6 6 6 (- 1 2 3) 6 6 6 (- 4 5 6) 6 6 6 (- 7 8 9)))							 																													'(- 6 6 6 1 2 3 6 6 6 4 5 6 6 6 6 7 8 9)	  																																"test27")		 
  (test (redux '(+ 1 2 3 (+ 4 (+ 5 5 5 (+ 6 6 (+ 7 7 (+ 8 (+ 9 (+ 1 1 ) 9 9) 8 8) 7 7) 6 6 6 )5  5 ) 4 4 4)))																										'(+ 1 2 3 4 5 5 5 6 6 7 7 8 9 1 1 9 9 8 8 7 7 6 6 6 5 5 4 4 4)  																											"test28")		 
)




       
