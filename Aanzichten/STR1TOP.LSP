;bovenaanzicht van een t1 trap

(defun c:str1top()
(command "layer" "S" "ALM_STAIR" "")
(setq h2 (getreal"\nWat is de hoogte van de trap (Osnap uit F3): "))
(setq h1 (getreal"\nWat is de breedte van de trap: "))
(setq a1 210)
(setq a2 225)
(setq rothoek (getreal "\n wat is de rotatiehoek  ( 0 - 360 ): "))

(setq h3 (/ h2 a1))
(if (= (rem h2 a1) 0) (setq treden (1- h3))
                       (setq treden (fix h3)) 
)

(setq h5 (+ (* treden a2) 55))
  
(setq tbw 60)     ;breedte stair stringer 

(setq p0 (getpoint"\nGeef het plaatsingspunt aan: "))
  
(setq p1 (list (car p0) (+ (cadr p0) (/ h1 2) tbw)))
(setq p2 (list (- (car p1) h5) (cadr p1)))
(setq p3 (list (car p2) (- (cadr p2) tbw)))
(setq p4 (list (car p1) (cadr p3)))
  
(setq p5 (list (car p1) (- (cadr p4) h1)))
(setq p6 (list (- (car p1) h5) (cadr p5)))
(setq p7 (list (car p6) (- (cadr p6) tbw)))
(setq p8 (list (car p1) (cadr p7)))
  
(setq p9 (list (+ (car p8) 60) (cadr p8)))
(setq p10 (list (car p9) (cadr p1)))
  
(setq p22 (list (- (car p2) 50) (cadr p2)))
(setq p23 (list (car p22) (cadr p3)))
(setq p24 (list (car p22) (cadr p6)))
(setq p25 (list (car p22) (cadr p7)))
(setq p26 (list (+ (car p22) 25) (- (cadr p22) (/ tbw 2))))
(setq p27 (list (+ (car p24) 25) (- (cadr p24) (/ tbw 2))))
  
(setq P40 (list (- (car p4) 0) (+ (cadr p4) 50))) 
(setq P41 (list (- (car p4) 5) (+ (cadr p4) 50)))
(setq P42 (list (- (car p4) 5) (+ (cadr p4) 0)))
  
(setq P50 (list (- (car p5) 5) (- (cadr p5) 0))) 
(setq P51 (list (- (car p5) 5) (- (cadr p5) 50)))
(setq P52 (list (- (car p5) 0) (- (cadr p5) 50)))

;centerline top 1  
(setq p100 (list (+ (car p1) 30) (+ (cadr p4) 25)))
(setq p101 (list (- (car p42) 30) (+ (cadr p4) 25)))

;centerline top 2  
(setq p200 (list (+ (car p5) 30) (- (cadr p5) 25)))
(setq p201 (list (- (car p50) 30) (- (cadr p5) 25)))

(command "pline" p1 p2 p3 p4 "c")             ;stringer 1
(command "pline" p5 p6 p7 p8 "c")             ;stringer 2
(command "pline" p4 p40 p41 p42 "c")          ;top plate 1 
(command "pline" p5 p50 p51 p52 "c")          ;top plate 2
(command "pline" p2 p22 p23 p3 "c")           ;voetplaat 1
(command "pline" p6 p24 p25 p7 "c")           ;voetplaat 2
(command "circle" p26 "6")                    ;anker gat 1
(command "circle" p27 "6")                    ;anker gat 2
  
(command "layer" "S" "ALM_CENTER" "")
(command "Line" P100 p101 "")                 ;centerline top plate 1
(command "Line" P200 p201 "")                 ;centerline top plate 2
(command "layer" "S" "ALM_STAIR" "")

(command "color" "8" )
(setq p11 (list (+ (car p6) 50) (cadr p6)))
(setq p12 (list (car p11) (+ (cadr p11) h1)))
(setq p20 (list (+ (car p12) a2 25) (cadr p12)))
(setq p21 (list (car p20) (cadr p11)))
(command "pline" p11 p12 p20 p21 "c")

(setq h6 1)
        (while (< h6 treden)
        (setq h7 (list (+ (car p11) (* h6 a2)) (cadr p11))) 
        (setq h8 (list (car h7) (+ (cadr h7) h1)))
	(setq h9 (list (+ (car h8) a2 25) (cadr h8)))
	(setq h10 (list (car h9) (cadr h7)))
        (command "pline" h7 h8 h9 h10 "c")
        (setq h6 (1+ h6))
        )
(command "color" "bylayer" )
(setq p13 (list (+ (car p11) 160) (+ (cadr p11) (/ h1 2))))
(setq p14 (list (- (car p5) 115) (cadr p13)))
(setq p15 (list (- (car p14) 320) (+ (cadr p14) 150)))
(setq p16 (list (car p15) (- (cadr p14) 150)))
(command "line" p13 p14 "")
;(command "pline" p14 p15 p16 "c")
(command "solid" p14 p15 p16 "" "")
; block maken

(setq rpt1 (list (- (car p25) 50) (- (cadr p25) 10)))
(setq rpt2 (list (+ (car p10) 50) (+ (cadr p10) 10)))
(setq bloknaam (strcat "stairtop_1_" (rtos h2) "x" (rtos h1)))
(command "block" bloknaam p0 "w" rpt1 rpt2 "")
(command "insert" bloknaam p0 "" "" "")

)
 
