;bovenaanzicht van een trap

(defun c:str3top()
(command "layer" "S" "0" "")
(setq h2 (getreal"\nWat is de hoogte van de trap: "))
(setq h1 (getreal"\nWat is de breedte van de trap: "))
(setq a1 210)
(setq a2 225)
(setq rothoek (getreal "\n wat is de rotatiehoek  ( 0 - 360 ): "))

(setq h3 (/ h2 a1))
(if (= (rem h2 a1) 0) (setq treden (1- h3))
                       (setq treden (fix h3)) 
)
(setq treden (1+ treden))
(setq h5 (+ (* treden a2) 10))
  
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
(setq p26 (list (+ (car p22) 25) (- (cadr p22) 25)))
(setq p27 (list (+ (car p24) 25) (- (cadr p24) 25)))

(setq P40 (list (- (car p4) 0) (+ (cadr p4) 50))) 
(setq P41 (list (- (car p4) 5) (+ (cadr p4) 50)))
(setq P42 (list (- (car p4) 5) (+ (cadr p4) 0)))
  
(setq P50 (list (- (car p5) 5) (- (cadr p5) 0))) 
(setq P51 (list (- (car p5) 5) (- (cadr p5) 50)))
(setq P52 (list (- (car p5) 0) (- (cadr p5) 50)))
  
(setq P60 (list (+ (car p3) 0) (+ (cadr p3) 50))) 
(setq P61 (list (+ (car p3) 5) (+ (cadr p3) 50)))
(setq P62 (list (+ (car p3) 5) (+ (cadr p3) 0)))
  
(setq P70 (list (+ (car p6) 5) (- (cadr p6) 0))) 
(setq P71 (list (+ (car p6) 5) (- (cadr p6) 50)))
(setq P72 (list (+ (car p6) 0) (- (cadr p6) 50)))

;centerline top 1  
(setq p100 (list (+ (car p1) 30) (+ (cadr p4) 25)))
(setq p101 (list (- (car p42) 30) (+ (cadr p4) 25)))

;centerline top 2  
(setq p200 (list (+ (car p5) 30) (- (cadr p5) 25)))
(setq p201 (list (- (car p50) 30) (- (cadr p5) 25)))

;centerline top 3  
(setq P300 (list (- (car p3) 30) (+ (cadr p3) 25)))
(setq P301 (list (+ (car p62) 30) (+ (cadr p3) 25)))

;centerline top 4  
(setq P400 (list (- (car p6) 30) (- (cadr p6) 25)))
(setq P401 (list (+ (car p70) 30) (- (cadr p6) 25)))

(command "pline" p1 p2 p3 p4 "c")         ;stringer 1
(command "pline" p5 p6 p7 p8 "c")         ;stringer 2
(command "pline" p4 p40 p41 p42 "c")      ;top plate 1 
(command "pline" p5 p50 p51 p52 "c")      ;top plate 2
(command "pline" p3 p60 p61 p62 "c")      ;bottom plate 1 
(command "pline" p6 p70 p71 p72 "c")      ;bottom plate 2 
  
(command "layer" "S" "ALM_CENTER" "")
(command "Line" P100 p101 "")                 ;centerline top plate 1
(command "Line" P200 p201 "")                 ;centerline top plate 2
(command "Line" P300 p301 "")                 ;centerline bottom plate 1
(command "Line" P400 p401 "")                 ;centerline bottom plate 2
(command "layer" "S" "ALM_STAIR" "")

(command "color" "8" )
(setq p11 (list (+ (car p6) 5) (cadr p6)))
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

(setq rpt1 (list (- (car p25) 100) (- (cadr p25) 100)))
(setq rpt2 (list (+ (car p10) 100) (+ (cadr p10) 100)))
(setq bloknaam (strcat "stairtop_3_" (rtos h2) "x" (rtos h1)))
(command "block" bloknaam p0 "w" rpt1 rpt2 "")
(command "layer" "S" "ALM_STAIR" "")
(command "insert" bloknaam p0 "" "" "")

)
 
