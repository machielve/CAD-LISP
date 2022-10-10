;; Load_All_Lisp.lsp
(defun C:LOAD-ALL-LISP ()
(setq LispPath "W:/Almacon Tools/Autocad/AutocadLISP/Stairs/14-09-2018 correctie/Extra/LISP/")
(setq LispList (vl-directory-files LispPath "*.lsp" 1))
(foreach Lisp LispList
(load (strcat LispPath Lisp))
); foreach
); function
(C:load-all-lisp); and, run this function
(prompt "\nAll Lisp has been loaded..")
(princ)