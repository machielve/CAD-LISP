;; Explode all 'New Type' Arrays  -  Lee Mac

(defun c:exarrays ( / doc enx )
   (vlax-for blk (vla-get-blocks (setq doc (vla-get-activedocument (vlax-get-acad-object))))
       (if (= :vlax-false (vla-get-isxref blk))
           (vlax-for obj blk
               (if
                   (and
                       (= "AcDbBlockReference" (vla-get-objectname obj))
                       (setq enx (entget (vlax-vla-object->ename obj)))
                       (setq enx (cdr (assoc 330 (member '(102 . "{ACAD_REACTORS") enx))))
                       (= "ACDBASSOCDEPENDENCY" (cdr (assoc 0 (entget enx))))
                   )
                   (explode obj)
               )
           )
       )
   )
   (vla-regen doc acallviewports)
   (princ)
)
(defun explode ( obj / lst )
   (if
       (and
           (= "AcDbBlockReference" (vla-get-objectname obj))
           (wcmatch (vla-get-effectivename obj) "`*U*")
           (vlax-write-enabled-p obj)
       )
       (if
           (not
               (vl-catch-all-error-p
                   (setq lst
                       (vl-catch-all-apply 'vlax-invoke (list obj 'explode))
                   )
               )
           )
           (progn
               (vla-delete obj)
               (foreach obj lst (explode obj))
           )
       )
   )
)
(vl-load-com) (princ)