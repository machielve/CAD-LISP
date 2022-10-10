;;POLYAREA.LSP
;;  Adds the area of one or more closed polylines
;;
(defun C:PolyArea (/ a ss n du)
  (command "layer" "S" "ALM_TXT" "")
  (setq a 0
        du (getvar "dimunit")
        ss (ssget '((0 . "*POLYLINE"))))
  (initget "belasting")
  (setq ff (cond ((getint "\nGelijkmatige belasting <500>: ")) (500)))

  (initget "verdiepingen")
  (setq vv (cond ((getint "\nAantal verdiepingen <1>: ")) (1)))

  (setq pp (getpoint "Tekstlocatie:   "))
  
  (if ss
    (progn
      (setq n (1- (sslength ss)))
      (while (>= n 0)
        (command "_.area" "_o" (ssname ss n))
        (setq a (+ a (getvar "area"))
              n (1- n)))
      
      (setq cl (rtos (/ (* (* (/ a 1000000) (+ ff 40) ) 9.81 vv ) 1000) 2))) 
      
    (alert "\nNo Polylines selected!"))
  (princ)
  (setq cll (strcat cl " kN."))
 (command "_Mtext" pp "H" "150" "" cll "") 
)
(princ)
