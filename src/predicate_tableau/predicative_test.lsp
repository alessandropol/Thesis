
;tautologie

(tableau '(-> (exist y (not (-> (C y) (not (C y))))) (all y (C y)) )) 
 
(tableau '(-> (and (exist x (and (C x) (E x))) (E a)) (C a)) )

(tableau '(-> (exist x (or (C x) (C x))) (all x (and (C x) (not (-> (C x) (not (C x))))) )))

(tableau '(-> (and (all x (-> (u x) (m x))) (all x (-> (g x) (u x)))) (all x (-> (g x) (m x)))) );uomini->mortali->greci

(tableau '(-> (all x (-> (C x) (not (C x)))) (all x (not (C x)))))

(tableau '(-> (and (all x (-> (M x) (F x))) (all x (-> (F x) (not (R x))))) (all x (-> (R x) (not (M x))))))

(tableau '(-> (not (exist x (and (C x) (B x)))) (all x (-> (B x) (not (C x))))))

(tableau '(-> (and (all x (C x)) (and (exist x (D x)) (exist x (not (D x))))) (not (all x (D x)))))

(tableau '(-> (exist x (and (B w) (not (B w)))) (all x (and (A w) (not (A w))))))

(tableau '(-> (and (all x (-> (not (A x)) (C x))) (not (C a))) (A a)))

(tableau '(-> (exist x (or (A x) (B x))) (or (exist x (A x)) (exist x (B x))))) 

(tableau '(-> (and (all x (-> (D x) (not (P x)))) (all x (-> (not (D x)) (S x)))) (all x (or (S x) (not (P x))))))





;opinioni

(tableau '(-> (exist x (or (P x) (D x))) (all x (and (C x) (-> (C x) (P X)))) ))
 
(tableau '(-> (not (all x (and (-> (P x) (U x)) (C x)))) (and (exist x (and (P x) (not (U x)))) (exist x (and (P x) (not (C x)))))))

(tableau '(-> (and (all x (-> (and (P x) (C x)) (and (P x) (U x)))) (and (P x) (not (U x)))) (and (P x) (not (C x)))))



