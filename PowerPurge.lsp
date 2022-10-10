; meervoudige purge

(defun c:PowerPurge()
(setq n (getint "\nEnter number of purges : "))
(repeat n

(Command "PURGE" "A" "" "N")))