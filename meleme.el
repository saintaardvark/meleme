;;; meleme.el --- show your mode line and what it does.

;;; Commentary:
;; meleme.el, yo!

;;; Code:

(defun meleme ()
  "Show your mode line and what it does."
  (interactive)
  (with-temp-buffer
    (insert (fmt "%s" mode-line-format))))

(provide 'meleme)
;;; meleme ends here
