;tautologia

(tableau '(-> (not (or a b)) (-> (and a b) (not a))) )

(tableau '(-> (and a b) (or b c)))

(tableau '(-> (and a (not b)) (or (not b) c)))

(tableau '(-> (and (-> a b) (-> b c)) (-> a c)) )

(tableau '(-> (-> r s) (-> (not s) (not r)) ) )

(tableau '(-> (not(or (not s) (not a))) (and a s)))

(tableau '(-> (and (-> (not n) p) (and (and (not p) (not v)) (not n))) (not (-> n p))))

(tableau '(->  (and (not (-> s p)) (-> n (not p))) (not (and (and (not p) (not s)) (not n))) ))

(tableau '(-> (not(-> (not(not(not a))) (not b))) (and (not a) (not(not b)) ) ) )




;opinione

(tableau '(->  (-> a b) (and (not(-> b a)) b)))

(tableau '(-> (-> (or a f) l) (and (and (not f) (not a)) (not l)) ) )
 
(tableau '(-> (-> c b) (or (or a c) b) ))
 
(tableau '(-> (and (-> c b) b) (and (-> a c) b) ))
 
 