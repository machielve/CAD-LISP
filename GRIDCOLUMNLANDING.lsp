(vl-load-com)
;;-----------------------------------------------
;; CDNC5-02.LSP
;; Bill Kramer
;; (modifications and enhancements by CAD Studio, www.cadstudio.cz , 2010-2014)
;;
;; ILSIMPLEMODE = T  for single intersection only  (large coord problem)
;;
;; Find all intersections between objects in
;; the selection set SS.
;;
;; ---------------------------------------------- BEGIN LISTING 1
;;
(defun get_all_inters_in_SS (SS /
			     SSL ;length of SS
			     PTS ;returning list
			     aObj1 ;Object 1
			     aObj2 ;Object 2
			     N1  ;Loop counter
			     N2  ;Loop counter
			     iPts ;intersects
				 C1 C2 C3
			     )

(defun iL->L (iPts / Pts) ; convert coordlist -> pointlist
(while (> (length iPts) 0)
  (setq Pts (cons (list	(car iPts)
						(cadr iPts)
						(caddr iPts))
					Pts)
	    iPts (cdddr iPts)))
 Pts
)
(defun iL2->L (iPts / Pts) ; convert coordlist -> pointlist 2D
(while (> (length iPts) 0)
  (setq Pts (cons (list	(car iPts)
						(cadr iPts)
						'0.0)
					Pts)
	    iPts (cddr iPts)))
 Pts
)

(defun DelDup ( l / x r ) ; remove duplicates
    (while l
        (setq x (car l)
              l (vl-remove x (cdr l))
              r (cons x r)
        )
    )
    (reverse r)
)


  (setq N1 0 ;index for outer loop
	SSL (sslength SS))
  ; Outer loop, first through second to last
  (while (< N1 (1- SSL)) ;  nebo <= ?
    ; Get object 1, convert to VLA object type
    (setq aObj1 (ssname SS N1)
	  aObj1 (vlax-ename->vla-object aObj1)
	  N2 (1+ N1)) ;index for inner loop
   ; self-intersections:
	(if (vlax-property-available-p aObj1 'Coordinates)(progn ; is it a curve? LWPOLY
		(setq C1 (iL2->L (vlax-get aObj1 'Coordinates)))
		(setq C2 (iL->L (vlax-invoke aObj1 'IntersectWith aObj1 0)))
		(setq C3 (vl-remove-if '(lambda ( x ) (member x C1)) C2))
;		(PRINT C1)(PRINT C2)(PRINT C3)
		(if C3 (foreach x C3 (setq Pts (cons x Pts)))) ; add selfs
	))
	(if (= (vlax-get aObj1 'ObjectName) "AcDbSpline")(progn ; SPLINE
		(setq C1 (iL->L (vlax-invoke aObj1 'IntersectWith aObj1 0)))
;		(PRINT C1)
		(if C1 (foreach x C1 (setq Pts (cons x Pts)))) ; add selfs
	))
    ; Inner loop, go through remaining objects
    (while (< N2 SSL) ; innser loop
      ; Get object 2, convert to VLA object
      (setq aObj2 (ssname SS N2)
	    aObj2 (vlax-ename->vla-object aObj2)
	    ; Find intersections of Objects
	    iPts (vla-intersectwith aObj1
		   aObj2 0)
	    ; variant result
	    iPts (vlax-variant-value iPts))
      ; Variant array has values?
      (if (> (vlax-safearray-get-u-bound iPts 1)
	     0)
	(progn ;array holds values, convert it
	  (setq iPts ;to a list.
		 (vlax-safearray->list iPts))
	  ;Loop through list constructing points
;	  (setq Pts (iL->L iPts)) ; must be global
;(if (> (length iPts) 3)(PRINT iPts)) --- LIST DUPLICATE INTERSECTIONS - THE RED/GREEN CASE GIVES TWO INTERSECTIONS !
	  (while (> (length iPts) 0)
	    (setq Pts (cons (list (car iPts)
				  (cadr iPts)
				  (caddr iPts))
			    Pts)
		  iPts (cdddr iPts))
		(if ILSIMPLEMODE (setq iPts nil))  ; ILSIMPLEMODE - take only the first intersection
	  )
	))
      (setq N2 (1+ N2))) ;inner loop end
    (setq N1 (1+ N1))) ;outer loop end
  Pts) ;return list of points found
;;-----------------------------------------------   END LISTING 1
;;
;; Remaining lines of code for download version, used to demonstrate and test the utility in Listing 1.
;;
;; Process - Create drawing with intersecting lines and lwpolylines.
;;           Load function set
;;           Run command function INTLINES
;;           Intersections are marked with POINT objects on current layer
;;
(defun C:GRIDCOLUMNLANDING ( / SS1 PT ptl oldos)
(command "layer" "S" "ALM_COLUMN" "")
  (prompt "\nINTLINES running to demonstrate GET_ALL_INTERS_IN_SS function.")
  (setq SS1 (ssget);(ssget "_X");(get_all_lines_as_SS)
	PTS (get_all_inters_in_ss SS1)
        )
  (setq ptl (length PTS)   PTS (deldup PTS)) ; duplicates - shouldn't be any
  (if (> ptl (length PTS)) (princ (strcat "\n" (itoa (- (length PTS) ptl)) " duplicates removed")))
  (vla-startundomark (vla-get-activedocument (vlax-get-acad-object)))
  (setvar "CMDECHO" 0)
  (setq oldos (getvar "OSMODE"))(setvar "OSMODE" 0)
  (foreach PT PTS ;;Loop through list of points
    (command "-insert" "Column Top Landing" PT "1" "0" " ")) ;;Create point object (you can also use INSERT, CIRCLE, etc. here)
;;  (setvar "PDMODE" 34) ;;display points so you can see them
  (command "_REGEN")
  (setvar "OSMODE" oldos)
  (vla-endundomark (vla-get-activedocument (vlax-get-acad-object)))
  (princ (strcat (itoa (length PTS)) " intersections found."))
  (princ)
)
;;
;;-----------------------------------------------
;;  Get all lines and lwpolyline objects in the
;;  drawing and return as a selection set.
;;
(defun get_all_Lines_as_SS ()
  (ssget "_X" '((0 . "LINE,LWPOLYLINE"))))
;;

(princ "\n(get_all_inters_in_SS) function and INTLINES command loaded.")
(prin1)
