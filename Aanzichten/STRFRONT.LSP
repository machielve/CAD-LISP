;vooraanzicht van een trap

(defun c:strfront()
(setq h2 (getreal"\nWat is de hoogte van de trap (Osnap uit F3): "))
(setq h1 (getreal"\nWat is de breedte van de trap: "))
; (setq a1 (getreal"\nWat is de maximale optrede van de trap: "))
(setq h3 (/ h2 210))
(setq h4 (1+ (fix h3)))
(setq rise (/ h2 h4))
  
(setq SSB 60 )        ;breedte stair stringer

(setq p1 (getpoint"\nGeef het plaatsingspunt aan: "))
(setq p2 (list (- (car p1) (/ h1 2) 50) (+ (cadr p1) 1100)))
(setq p3 (list (car p2) (- (cadr p2) 1100 h2)))
(setq p4 (list (+ (car p3) 50) (cadr p3)))
(setq p5 (list (car p4) (cadr p2)))

(setq p6 (list (+ (car p1) (+ (/ h1 2) 50)) (cadr p5)))
(setq p7 (list (car p6) (- (cadr p6) 1100 h2)))
(setq p8 (list (- (car p7) 50)  (cadr p7)))
(setq p9 (list (car p8) (cadr p5)))
  
(setq p10 (list (car p5) (cadr p1)))
(setq p11 (list (car p9) (cadr p1)))

(setq p12 (list (car p2) (- (cadr p2) 50)))
(setq p13 (list (car p5) (cadr p12)))
(setq p14 (list (car p9) (cadr p12)))
(setq p15 (list (car p6) (cadr p12)))

(setq p16 (list (- (car p3) 10) (+ (cadr p3) 5)))
(setq p17 (list (car p5) (cadr p16)))
(setq p18 (list (car p9) (cadr p16)))
(setq p19 (list (+ (car p6) 10) (cadr p16)))


(setq p20 (list (car p3) (+ (cadr p3) rise 1050)))
(setq p21 (list (car p5) (cadr p20)))
(setq p22 (list (car p9) (cadr p20)))
(setq p23 (list (car p6) (cadr p20)))
  
  
(setq p50 (list (car p10) (- (cadr p10) 50)))
(setq p51 (list (car p11) (- (cadr p11) 50)))
  
(setq p60 (list (- (car p10) SSB) (cadr p10)))
(setq p61 (list (- (car p4) SSB) (cadr p4)))
  
(setq p70 (list (+ (car p11) SSB) (cadr p11)))
(setq p71 (list (+ (car p8) SSB) (cadr p8)))
  

(command "layer" "S" "ALM_STAIR" "")
(command "pline" p2 p3 p4 p5 "c")               ;stringer 1 + handrail 1
(command "pline" p6 p7 p8 p9 "c")               ;stringer 2 + handrail 2
(command "pline" p60 p61 p4 p10 "c")            ;new stringer 1  
(command "pline" p11 p8 p71 p70 "c")            ;new stringer 2  
(command "line" p10 p11 "")                     ;bovenkant vloer
(command "line" p50 p51 "")                     ;onderkant top step
(command "line" p12 p13 "")                     ;handrail 1 doorsnede
(command "line" p14 p15 "")                     ;handrail 2 doorsnede
(command "line" p16 p17 "")                     ;voetplaat 1
(command "line" p18 p19 "")                     ;voetplaat 2
(command "line" p20 p21 "")                     ;bottom newel 1 top
(command "line" p22 p23 "")                     ;bottom newel 2 top

(setq h4 (1- h4))
(command "color" "8" )

(setq h6 1)
        (while (<= h6 h4)
        (setq h7 (list (car p8) (+ (cadr p8) (* h6 rise)))) 
        (setq h8 (list (car p4) (cadr h7)))
        (setq h9 (list (car p4) (- (cadr h7) 50)))
        (setq h10 (list (car p8) (cadr h9)))

        (command "pline" h7 h8 h9 h10 "")
        (setq h6 (1+ h6))
        )
(command "color" "bylayer" )

(setq bpt1 (list (- (car p3) 10) (- (cadr p3) 10)))
(setq bpt2 (list (+ (car p6) 10) (+ (cadr p6) 10)))
(setq bloknaam (strcat "stairfront_0_" (rtos h2) "x" (rtos h1) "var" ))
(command "block" bloknaam p1 "w" bpt1 bpt2 "")
(command "insert" bloknaam p1 "" "" "")

)
