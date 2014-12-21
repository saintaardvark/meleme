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
        ;; Hm: Have to use print to make this work with with-output-to-temp-buffer.
        (print (format "%s\n" (car list)))
        (setq list (cdr list))))))

(defun meleme-display()
  "Show your mode line in a temporary buffer."
  (interactive)
  (with-output-to-temp-buffer "*meleme*"
    (meleme)))

(provide 'meleme)
;;; meleme ends here
