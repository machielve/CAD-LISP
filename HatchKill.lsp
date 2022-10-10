Sub filterKB()
(defun c:HatchKill ( / d )
    (vlax-for b (vla-get-blocks (setq d (vla-get-activedocument (vlax-get-acad-object))))
        (if (= :vlax-false (vla-get-isxref b))
            (vlax-for o b
                (if (and (= "AcDbHatch" (vla-get-objectname o))
                         (vlax-write-enabled-p o)
                    )
                    (vla-delete o)
                )
            )
        )
    )
    (vla-regen d acallviewports)
    (princ)
)
(vl-load-com) (princ)
