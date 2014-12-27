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
        (print (format "That makes this string: |%s|" (format-mode-line (car list))))
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
                ((stringp element)
                 (format "%s: %s" (meleme-lookup-string element) (eval element)))
                 (t
                  (format "No documentation yet: %s" element)))))

(defun meleme-lookup-string (element)
  "Look up help string for modeline."
  (interactive)
  ;; (message (format "FIXME: Just received '%s'" element));
  (let ((docstring (documentation-property 'mode-line-format 'variable-documentation)))
    (if (string-match (format "  %s.*\n" element) docstring)
        (match-string 0 docstring)
      ("Cannot find that"))))


(provide 'meleme)
;;; meleme ends here
