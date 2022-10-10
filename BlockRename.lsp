(defun c:BlockRenamer (/ b f r n gl bl)
  ;; Alan J. Thompson, 03.26.10
  (vl-load-com)
  (cond
    ((and (/= "" (setq b (getstring t "Block name pattern: ")))
          (/= "" (setq f (getstring t "String to replace: ")))
          (/= "" (setq r (getstring t "Replacement string: ")))
     ) ;_ and
     (or *AcadDoc* (setq *AcadDoc* (vla-get-activedocument (vlax-get-acad-object))))
     (vlax-for x (vla-get-blocks *AcadDoc*)
       (if
         (and (not (wcmatch (setq n (vla-get-name x)) "*|*,_*")) (wcmatch (strcase n) (strcase b)))
          (if (vl-catch-all-error-p
                (vl-catch-all-apply (function vla-put-name) (list x (vl-string-subst r f n)))
              ) ;_ vl-catch-all-error-p
            (setq bl (cons n bl))
            (setq gl (cons (cons n (vla-get-name x)) gl))
          ) ;_ if
       ) ;_ if
     ) ;_ vlax-for
     (if (or gl bl)
       (alert
         (strcat
           (if gl
             (strcat "The following blocks were renamed (Old . New):\n\n"
                     (vl-princ-to-string (vl-sort gl (function (lambda (a b) (< (car a) (car b))))))
             ) ;_ strcat
             ""
           ) ;_ if
           (if bl
             (strcat "\n\n\nThe following blocks could NOT be renamed:\n\n"
                     (vl-princ-to-string (vl-sort bl '<))
             ) ;_ strcat
             ""
           ) ;_ if
         ) ;_ strcat
       ) ;_ alert
       (alert "Nothing renamed.")
     ) ;_ if
    )
  ) ;_ cond
  (princ)
) ;_ defun
