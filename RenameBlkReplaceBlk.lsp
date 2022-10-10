; Author:      Roy Klein Gebbinck (www.b-k-g.nl)
; Version:     20180711: First version.
; Created for: https://forum.bricsys.com/discussion/33839/anonymous-blocks?

(defun KGA_Sys_ApplyAlt (expr varLst)
  (not (vl-catch-all-error-p (vl-catch-all-apply expr varLst)))
)

(defun c:RenameBlk ( / blk doc enm nme obj)
  (setq doc (vla-get-activedocument (vlax-get-acad-object)))
  (vla-endundomark doc)
  (vla-startundomark doc)
  (if
    (and
      (setq enm (car (entsel "\nSelect insert: ")))
      (setq obj (vlax-ename->vla-object enm))
      (or
        (= "AcDbBlockReference" (vla-get-objectname obj))
        (prompt "\nError: not an insert ")
      )
      (setq blk (vla-item (vla-get-blocks doc) (vla-get-name obj)))
      (or
        (= :vlax-false (vla-get-isxref blk))
        (prompt "\nError: this is an insert of an xref ")
      )
      (setq nme (getstring T "\nNew name: "))
      (or
        (snvalid nme)
        (prompt "\nError: name not valid ")
      )
      (or
        (not (tblobjname "block" nme))
        (princ "\nError: name is already in use ")
      )
    )
    (if (KGA_Sys_ApplyAlt 'vla-put-name (list blk nme))
      (princ "\nBlock successfully renamed ")
    )
  )
  (vla-endundomark doc)
  (princ)
)

(defun c:ReplaceBlk ( / doc nme res ss)
  (setq doc (vla-get-activedocument (vlax-get-acad-object)))
  (vla-endundomark doc)
  (vla-startundomark doc)
  (if
    (and
      (setq ss (ssget '((0 . "INSERT") (66 . 0)))) ; Only select inserts without attributes.
      (setq nme (getstring T "\nName of replacement block or xref: "))
      (or
        (tblobjname "block" nme)
        (princ "\nError: replacement not found ")
      )
    )
    (progn
      (setq res
        (mapcar
          '(lambda (enm) (KGA_Sys_ApplyAlt 'vla-put-name (list (vlax-ename->vla-object enm) nme)))
          (vle-selectionset->list ss)
        )
      )
      (princ
        (strcat
          "\n"
          (itoa (length (vl-remove nil res)))
          "/"
          (itoa (length res))
          " Block(s) successfully replaced "
        )
      )
    )
  )
  (vla-endundomark doc)
  (princ)
)    
