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
        (let ((element (car list)))
          (meleme-format-as-org-table element (meleme-analyze element) (format-mode-line element)))
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

(defun meleme-format-as-org-table (&rest list)
  "Format a given line as an org-table line."
  (interactive)
  ;; FIXME: Here and up above, see if dolist should be used.
  ;; FIXME: See if apply/&rest will work. http://stackoverflow.com/questions/4970111/what-does-rest-mean-in-elisp
  ;; (let ((string "| "))
  ;;   (setq string (concat string (mapconcat 'identity list " | ")))))
  ;; (mapconcat 'identity 'list " | "))

  (let ((string "|"))
    (while list
      (let ((element (car list)))
        (setq string (concat string (format " %s |" element)))
        (setq list (cdr list))))
    (print string)))

(provide 'meleme)
;;; meleme ends here
