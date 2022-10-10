(defun c:add$ ( / ss i blk blks def AttObj)
    (and
       (setq ss (ssget '((0 . "INSERT"))))
       (setq i (sslength ss))
       (while (> i 0)
          (setq blk (cdr (assoc 2 (entget (ssname ss (setq i (1- i)))))))
          (if (not (vl-position blk blks))(setq blks (cons blk blks)))
       )
    )
    (foreach blk blks
         (setq def (vla-item (vla-get-blocks (vla-get-activedocument (vlax-get-acad-object))) blk))
         (setq AttObj
            (vla-addattribute def
              8
              acattributemodelockposition
              "Enter Item #"
              (vlax-3D-point 72 84)
              "ITEM\U+0020$"
              "$"
            )
         )
         (vlax-put AttObj 'Alignment acAlignmentmiddle) ;; 4
         (command "_.attsync" "_N" blk)
     )
    (princ)
)
(vl-load-com) (princ)