(defun c:AUTORECT ( / tpp1 pt1 pt2 intpt1 intpt2 intpt3 intpt4 ss)
(setq width (getreal "enter width"))
(setq obj (entsel "pick crossing line"))
(setq obj2 (vlax-ename->vla-object (car obj))) ;convert pick line to vl object
(setq tpp1 (entget (car obj) ) )
(setq pt1 (cdr (assoc 10 tpp1) ) ) 
(setq pt2 (cdr (assoc 11 tpp1) ) )
(setq ss (ssget "F" (list pt1 pt2)))

(setq x (- (sslength ss)1))
(setq obj1 (vlax-ename->vla-object (ssname ss (setq x (- x 1)))))
(setq intpt1 (vlax-invoke obj2 'intersectWith obj1 acExtendThisEntity))
(repeat (sslength ss)

(setq obj3 (vlax-ename->vla-object (ssname ss (setq x (- x 1)))))
(setq intpt2 (vlax-invoke obj2 'intersectWith obj3 acExtendThisEntity))

(setq intpt3 (polar intpt1 0.0 width))
(setq intpt4 (polar intpt2 0.0 width))

(command "pline" intpt1 intpt2 intpt3 intpt4 "C")
(setq intpt1 intpt2)

) ; repeat
) 