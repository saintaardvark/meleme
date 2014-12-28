;;; meleme.el --- show your mode line and what it does.

;;; Commentary:
;; meleme.el, yo!

;;; Code:

(defun meleme-display-as-org ()
  "Show your mode line and what it does."
  (with-current-buffer (get-buffer-create "*meleme*")
    ;; FIXME: Really need to be setting mode of display more flexibly.
    (delete-region (point-min) (point-max))
    (org-mode)
    (let ((list mode-line-format))
      (while list
        (let ((element (car list)))
          (meleme-format-as-org-table element (type-of element) (meleme-analyze element) (format-mode-line element)))
        (setq list (cdr list))))
    (goto-char (point-min))
    (org-table-align)))

(defun meleme()
  "Show your mode line in a temporary buffer."
  (interactive)
  ;; (with-output-to-temp-buffer "*meleme*"
  ;;   (meleme-display)))
  (save-excursion
    (meleme-display-as-org)))

(defun meleme-analyze (element)
  "Display what each ELEMENT of the mode format does."
  (replace-regexp-in-string "\n" " "
                            (cond ((functionp element)
                                   (format "%s: %s" (documentation element) (eval element)))
                                  ((symbolp element)
                                   (format "%s: %s" (documentation-property element 'variable-documentation) (eval element)))
                                  ((stringp element)
                                   (format "%s: %s" (meleme-lookup-string element) (eval element)))
                                  (t
                                   (format "No documentation yet: %s" element)))))

(defun meleme-lookup-string (element)
  "Look up ELEMENT in help string for modeline."
  (interactive)
  ;; (message (format "FIXME: Just received '%s'" element));
  (let ((docstring (documentation-property 'mode-line-format 'variable-documentation)))
    (if (string-match (format "  %s.*\n" element) docstring)
        (match-string 0 docstring)
      (quote "Cannot find that"))))

(defun meleme-format-as-org-table (&rest list)
  "Format LIST as an org-table line."
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
    (insert string "\n")))

(provide 'meleme)
;;; meleme ends here
