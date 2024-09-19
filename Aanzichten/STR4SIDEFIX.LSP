;zijaanzicht van een t4 trap

(defun c:str4sidefix()

(command "layer" "S" "ALM_STAIR" "")
(setq H (getreal"\nWat is de hoogte van de trap (Osnap uit F3): "))
(setq a1 210)
(setq a2 225)
(setq LofR (strcase (getstring"\nLinkse of Rechtse plaatsing (L / R): ")))

(setq h1 (/ H a1))
(if (= (rem H a1) 0) (setq treden (1- h1))
                      (setq treden (fix h1))
)
(setq a3 (/ H (1+ treden)))
(setq treden (+ 1 treden))
(setq H (* a3 (1+ treden)))
(setq G (+ (* treden a2) 170))
(setq rise (fix (/ H (1+ treden))))
;(print rise)

(setq h2 (* treden rise))
;(print h2)
(setq h3 (* treden a1))
;(print h3)
(setq h4 (sqrt (+ (expt h2 2)(expt h3 2))))
;(print h4)
(setq anglerad (atan a3 a2))
;(print anglerad)
(setq anglergr (* (/ 180 pi) (atan a3 a2)))
;(print anglergr)
  
(setq DHR 30)             ;dikte/hoogte handrail
(setq DKR 30)             ;dikte/hoogte kneerail
(setq HSS 200)            ;hoogte stringer profiel
(setq DIN 30)             ;dikte inner newel
(setq DIN2 (/ DIN 2))     ;halve dikte inner newel

;top-newel
(setq p1 (getpoint"\nGeef het plaatsingspunt aan: "))                                         ;begin punt
(setq p2 (list (car p1)                     (+ (cadr p1) 1100)))                              ;Bovenkant newel buiten
(setq p3 (list (- (car p2) 50)              (cadr p2)))                                       ;bovenkant newel binnen
(setq p12 (list (car p3)                    (cadr p1)))                                       ;vloer niveau  
  
(setq p10 (list (car p3)                    (- (cadr p12) 255)))                              ;onderkant newel binnen
(setq p11 (list (+ (car p10) 50)            (cadr p10)))                                      ;onderkant newel buiten 
  
(setq YY (/ 70 (cos anglerad)))  
(setq X1 (* 70 70))  
(setq X2 (* YY YY))  
(setq X3 (- X2 X1))  
(setq XX (sqrt X3))  
  
(setq p8 (list (car p3)                     (+ (cadr p12) XX)))                               ;bovenkant stringer
(setq p9 (list (car p3)                     (- (cadr p8) (/ HSS (cos anglerad)))))            ;onderkant stringer  
  
(setq p6 (list (car p3)                     (+ (cadr p8) 500)))                               ;bovenkant knierail          
(setq p7 (list (car p3)                     (- (cadr p6) (/ DKR (cos anglerad)))))            ;onderkant knierail    
  
(setq p4 (list (car p3)                     (+ (cadr p6) 500)))                               ;bovenkant handrail
(setq p5 (list (car p3)                     (- (cadr p4) (/ DHR (cos anglerad)))))            ;onderkant handrail
  
(command "pline" p1 p2 p3 p10 p11 "c")      ;buitenlijn
(command "line" p1 p12 "")                  ;vloer niveau


;bottom-newel
(setq p27 (list (- (car p1) (- G 50) )      (- (cadr p1) (* treden a3) 255)))                 ;onderkant newel buiten
(setq p28 (list (+ (car p27) 50)            (cadr p27)))                                      ;onderkant newel binnen
(setq p20 (list (car p27)                   (+ (cadr p28) 255)))                              ;vloer niveau
  
(setq p25 (list (car p28)                   (+ (cadr p20) 1100)))                             ;bovenkant newel binnen
(setq p26 (list (- (car p28) 50)            (cadr p25)))                                      ;bovenkant newel buiten
  
(setq YY (/ 50 (cos anglerad)))  
(setq X1 (* 50 50))  
(setq X2 (* YY YY))  
(setq X3 (- X2 X1))  
(setq XX (sqrt X3)) 
    
(setq p40 (list (car p28)                   (+ (cadr p20) XX)))                               ;bovenkant stringer
(setq p41 (list (car p28)                   (- (cadr p40) (/ HSS (cos anglerad)))))           ;onderkant stringer

(setq p22 (list (car p28)                   (+ (cadr p40) 500)))                              ;bovenkant knierail
(setq p21 (list (car p28)                   (- (cadr p22) (/ DKR (cos anglerad)))))           ;onderkant knierail
  
(setq p24 (list (car p28)                   (+ (cadr p22) 500)))                              ;bovenkant handrail
(setq p23 (list (car p28)                   (- (cadr p24) (/ DHR (cos anglerad)))))           ;onderkant handrail
  
(command "pline" p27 p28 p25 p26 "c")       ;buitenlijn
;(command "line" p20 p40 "")                 ;vloer niveau


;rechtstukje op base-plate
(setq hy (/ HSS (cos anglerad)))
;(print hy)
(setq hv (+ (- hy a3) 5)) 
;(print hv)
(setq hs (/ hv (sin anglerad)))
;(print hs)
(setq hz (sqrt (- (expt hs 2)(expt hv 2))))
;(print hz)
(setq p29 (list (+ (car p28) hz) (cadr p28)))

(command "line" p4 p24 "")
(command "line" p5 p23 "")
(command "line" p6 p22 "")
(command "line" p7 p21 "")
(command "line" p8 p40 "")
(command "line" p9 p41 "")


;tekenen inner-newels
(if (and (> treden 6) (< treden 15)) 
    (progn 

      (setq p49 (list (/ (+ (car p8) (car p40)) 2) (/ (+ (cadr p8) (cadr p40)) 2)))
      (setq p50 (list (/ (+ (car p7) (car p21)) 2) (/ (+ (cadr p7) (cadr p21)) 2)))
      (setq p51 (list (/ (+ (car p6) (car p22)) 2) (/ (+ (cadr p6) (cadr p22)) 2)))
      (setq p52 (list (/ (+ (car p5) (car p23)) 2) (/ (+ (cadr p5) (cadr p23)) 2)))

      (setq p53 (list (- (car p49) DIN2) (- (cadr p49) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p54 (list (- (car p50) DIN2) (- (cadr p50) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p55 (list (+ (car p49) DIN2) (+ (cadr p49) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p56 (list (+ (car p50) DIN2) (+ (cadr p50) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p57 (list (car p53) (+ (cadr p53) 500)))
      (setq p58 (list (car p54) (+ (cadr p54) 500)))
      (setq p59 (list (car p55) (+ (cadr p55) 500)))
      (setq p60 (list (car p56) (+ (cadr p56) 500)))
      (command "line" p53 p54 "")
      (command "line" p55 p56 "")
      (command "line" p57 p58 "")
      (command "line" p59 p60 "")
      );progn
);if
  

(if (> treden 14) 
    (progn 

      (setq p61 (list (+ (/ (- (car p8) (car p40)) 3) (car p40)) (+ (/ (- (cadr p8) (cadr p40)) 3) (cadr p40))))
      (setq p62 (list (+ (/ (- (car p7) (car p21)) 3) (car p21)) (+ (/ (- (cadr p7) (cadr p21)) 3) (cadr p21))))
  
      (setq p63 (list (- (car p61) DIN2) (- (cadr p61) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p64 (list (- (car p62) DIN2) (- (cadr p62) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p65 (list (+ (car p61) DIN2) (+ (cadr p61) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p66 (list (+ (car p62) DIN2) (+ (cadr p62) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p67 (list (car p63) (+ (cadr p63) 500)))
      (setq p68 (list (car p64) (+ (cadr p64) 500)))
      (setq p69 (list (car p65) (+ (cadr p65) 500)))
      (setq p70 (list (car p66) (+ (cadr p66) 500)))
      (command "line" p63 p64 "")
      (command "line" p65 p66 "")
      (command "line" p67 p68 "")
      (command "line" p69 p70 "")


      (setq p71 (list (+ (* (/ (- (car p8) (car p40)) 3) 2) (car p40)) (+ (* (/ (- (cadr p8) (cadr p40)) 3) 2) (cadr p40))))
      (setq p72 (list (+ (* (/ (- (car p7) (car p21)) 3) 2) (car p21)) (+ (* (/ (- (cadr p7) (cadr p21)) 3) 2) (cadr p21))))
  
      (setq p73 (list (- (car p71) DIN2) (- (cadr p71) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p74 (list (- (car p72) DIN2) (- (cadr p72) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p75 (list (+ (car p71) DIN2) (+ (cadr p71) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p76 (list (+ (car p72) DIN2) (+ (cadr p72) (* (/ (sin anglerad) (cos anglerad)) DIN2))))
      (setq p77 (list (car p73) (+ (cadr p73) 525)))
      (setq p78 (list (car p74) (+ (cadr p74) 525)))
      (setq p79 (list (car p75) (+ (cadr p75) 525)))
      (setq p80 (list (car p76) (+ (cadr p76) 525)))
      (command "line" p73 p74 "")
      (command "line" p75 p76 "")
      (command "line" p77 p78 "")
      (command "line" p79 p80 "")

      
      
);progn
);if

; tekenen traptreden
(command "color" "8" )
(setq a4 0)
(while (< a4 treden)
(setq a5 (* a2 a4))
(setq a6 (* a3 a4))
      (setq p81 (list (+ (car p20) a5)              (+ (cadr p20) a6)))
      (setq p82 (list (+ (car p81) a2 25)           (cadr p81)))
      (setq p83 (list (car p82)                     (- (cadr p82) 45)))
      (setq p84 (list (car p81)                     (cadr p83))) 
(command "pline" p81 p82 p83 p84 "c")
(setq a4 (+ a4 1))
)
(command "color" "bylayer" )
  
;tekenen wel trede
(command "color" "8" )
(setq a5 (* a2 a4))
(setq a6 (* a3 a4))

      (setq p81 (list (+ (car p20) a5)              (+ (cadr p20) a6)))
      (setq p82 (list (+ (car p81) 120)             (cadr p81)))
      (setq p83 (list (car p82)                     (- (cadr p82) 45)))
      (setq p84 (list (car p81)                     (cadr p83))) 
(command "pline" p81 p82 p83 p84 "c")

(command "color" "bylayer")

  
; block maken
(setq mirrorpnt1 (list (- (car p27) 10) (- (cadr p27) 10)))
(setq mirrorpnt2 (list (+ (car p2) 10) (+ (cadr p2) 10)))
(setq H (- H a3))
(setq bloknaam (strcat "stairside_4_" (rtos H)))
(command "block" bloknaam p1 "w" mirrorpnt1 mirrorpnt2 "")
(command "insert" bloknaam p1 "" "" "")

(if (= LofR "R") 
    (progn 
       (command "mirror" "w" mirrorpnt1 mirrorpnt2 "" p2 p11 "y")
    );progn
);if

(command "redraw")

)
 
