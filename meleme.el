;;; meleme.el --- show your mode line and what it does.

;;; Commentary:
;; meleme.el, yo!

;;; Code:

(defun meleme-display ()
  "Show your mode line and what it does."
  (save-excursion
    (let ((list mode-line-format))
      (while list
        ;; Hm: Have to use print to make this work with with-output-to-temp-buffer.
        (print (format "%s : %s" (car list) (meleme-analyze (car list))))
        (print "----")
        (setq list (cdr list))))))

(defun meleme()
  "Show your mode line in a temporary buffer."
  (interactive)
  (with-output-to-temp-buffer "*meleme*"
    (meleme-display)))

(defun meleme-analyze (element)
  "Display what each ELEMENT of the mode format does."
  (format "%s : %s"
          (type-of element)
          (cond ((functionp element)
                 (format "%s: %s" (documentation element) (eval element)))
                ((symbolp element)
                 (format "%s: %s" (documentation-property element 'variable-documentation) (eval element)))
                 (t
                  (format "No documentation yet: %s" element)))))

(provide 'meleme)
;;; meleme ends here
