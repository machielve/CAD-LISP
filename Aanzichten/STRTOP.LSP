;bovenaanzicht van een t0 trap

(defun c:strtop()
(command "layer" "S" "0" "")
(setq h2 (getreal"\nWat is de hoogte van de trap (Osnap uit F3): "))
(setq h1 (getreal"\nWat is de breedte van de trap: "))
(setq a1 210)
(setq a2 225)
(setq rothoek (getreal "\n wat is de rotatiehoek  ( 0 - 360 ): "))

(setq h3 (/ h2 a1))
(if (= (rem h2 a1) 0) (setq treden (1- h3))
                      (setq treden (fix h3)) 
)

(setq h5 (+ (* treden a2) 170))
  
(setq tbw 60)     ;breedte stair stringer  
(setq wtb 120)    ;diepte wel trede
(setq tnb 50)     ;breedte top newel  
(setq vpb 80)     ;breedte voetplaat
(setq vpl 200)    ;lengte voetplaat  

(setq p0 (getpoint"\nGeef het plaatsingspunt aan: "))                         ;begin punt
(setq p1 (list (-(car p0) tnb)              (+ (cadr p0) (/ h1 2) tbw)))      ;boven stringer rechts boven
(setq p2 (list (- (car p0) (- h5 tnb))      (cadr p1)))                       ;boven stringer links boven
(setq p3 (list (car p2)                     (- (cadr p2) tbw)))               ;boven stringer links onder
(setq p4 (list (car p1)                     (cadr p3)))                       ;boven stringer rechts onder
  
(setq p5 (list (car p1)                     (- (cadr p4) h1)))                ;onder stringer rechts boven
(setq p6 (list (- (car p0) (- h5 tnb))      (cadr p5)))                       ;onder stringer links boven
(setq p7 (list (car p6)                     (- (cadr p6) tbw)))               ;onder stringer links onder
(setq p8 (list (car p1)                     (cadr p7)))                       ;onder stringer rechts onder
  
(setq p9 (list (- (car p0) wtb)             (cadr p5)))                       ;wel trede links boven
(setq p10 (list (car p9)                    (cadr p4)))                       ;wel trede links onder
  
(setq P40 (list (car p4)                    (+ (cadr p4) tnb)))               ;top newel boven links boven
(setq P41 (list (+ (car p4) tnb)            (+ (cadr p4) tnb)))               ;top newel boven rechts boven
(setq P42 (list (+ (car p4) tnb)            (cadr p4)))                       ;top newel boven rechts onder
  
(setq P50 (list (+ (car p5) tnb)            (cadr p5)))                       ;top newel onder rechts boven
(setq P51 (list (+ (car p5) tnb)            (- (cadr p5) tnb)))               ;top newel onder rechts onder
(setq P52 (list (car p5)                    (- (cadr p5) tnb)))               ;top newel onder links onder
  
(setq P60 (list (- (car p3) tnb)            (cadr p3)))                       ;bot newel boven links onder
(setq P61 (list (- (car p3) tnb)            (+ (cadr p3) tnb)))               ;bot newel boven links boven
(setq P62 (list (car p3)                    (+ (cadr p3) tnb)))               ;bot newel boven rechts boven
  
(setq P70 (list (- (car p6) tnb)            (cadr p6)))                       ;bot newel onder links boven
(setq P71 (list (- (car p6) tnb)            (- (cadr p6) tnb)))               ;bot newel onder links onder
(setq P72 (list (car p6)                    (- (cadr p6) tnb)))               ;bot newel onder rechts onder
  
(setq p20 (list (- (car p60) tnb)           (cadr p3)))                       ;boven voetplaat links onder
(setq p21 (list (car p20)                   (+ (cadr p20) vpb)))              ;boven voetplaat links boven
(setq p22 (list (+ (car p21) vpl)           (cadr p21)))                      ;boven voetplaat rechts boven
(setq p23 (list (car p22)                   (cadr p20)))                      ;boven voetplaat rechts onder
  
(setq p24 (list (+ (car p21) 25)            (- (cadr p21) (/ vpb 2))))        ;anker gat onder
  
(setq p25 (list (- (car p70) tnb)           (cadr p6)))                       ;onder voetplaat links onder
(setq p26 (list (car p25)                   (- (cadr p25) vpb)))              ;onder voetplaat links boven
(setq p27 (list (+ (car p26) vpl)           (cadr p26)))                      ;onder voetplaat rechts boven
(setq p28 (list (car p27)                   (cadr p25)))                      ;onder voetplaat rechts onder
  
(setq p29 (list (+ (car p25) 25)            (- (cadr p25) (/ vpb 2))))        ;anker gat boven
  
;trepbomen tekenen
(command "pline" p1 p2 p3 p4 "c")           ;stringer boven
(command "pline" p5 p6 p7 p8 "c")           ;stringer onder

(command "pline" p4 p40 p41 p42 "c")        ;top newel boven 
(command "pline" p5 p50 p51 p52 "c")        ;top newel onder
  
(command "pline" p3 p60 p61 p62 "c")        ;bot newel boven 
(command "pline" p6 p70 p71 p72 "c")        ;bot newel onder
  
(command "pline" p20 p21 p22 p23 "c")       ;voetplaat boven
(command "pline" p25 p26 p27 p28 "c")       ;voetplaat onder
  
(command "circle" p24 "6")                  ;anker gat boven
(command "circle" p29 "6")                  ;anker gat onder
  
;tekenen traptreden
(command "color" "8" )
(setq p100 (list (+ (car p70) tnb)          (cadr p70)))
(setq p101 (list (car p100)                 (+ (cadr p100) h1)))
(setq p102 (list (+ (car p101) a2 15)       (cadr p101)))
(setq p103 (list (car p102)                 (cadr p100)))
  
(command "pline" p100 p101 p102 p103 "c")

(setq h6 1)
        (while (< h6 treden)
        (setq h7 (list (+ (car p100) (* h6 a2))  (cadr p100))) 
        (setq h8 (list (car h7)                 (+ (cadr h7) h1)))
	(setq h9 (list (+ (car h8) a2 25) (cadr h8)))
	(setq h10 (list (car h9) (cadr h7)))
        (command "pline" h7 h8 h9 h10 "c")
        (setq h6 (1+ h6))
        )
(command "color" "bylayer" )

;tekenen wel trede  
(command "pline" p42 p50 p9 p10 "c")         
  
;Loop pijl tekeken 
(setq p13 (list (+ (car p100) 160)          (cadr p0)))
(setq p14 (list (- (car p5) 115)            (cadr p13)))
(setq p15 (list (- (car p14) 320)           (+ (cadr p14) 150)))
(setq p16 (list (car p15) (- (cadr p14) 150)))
(command "line" p13 p14 "")
;(command "pline" p14 p15 p16 "c")
(command "solid" p14 p15 p16 "" "")

; block maken

(setq rpt1 (list (- (car p26) 50)       (- (cadr p26) 50)))
(setq rpt2 (list (+ (car p0) 50)        (+ (cadr p1) 50)))
(setq bloknaam (strcat "stairtop_0_" (rtos h2) "x" (rtos h1)))
(command "block" bloknaam p0 "w" rpt1 rpt2 "")
(command "layer" "S" "ALM_STAIR" "")
(command "insert" bloknaam p0 "" "" "")
  

)
 
