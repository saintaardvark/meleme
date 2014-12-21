;;; meleme.el --- show your mode line and what it does.

;;; Commentary:
;; meleme.el, yo!

;;; Code:

(defun meleme ()
  "Show your mode line and what it does."
  (interactive)
  (save-excursion
    (let ((list mode-line-format))
      (while list
        (insert (format "%s\n" (car list)))
        (setq list (cdr list))))))


(provide 'meleme)
;;; meleme ends here
