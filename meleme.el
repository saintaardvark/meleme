;;; meleme.el --- show your mode line and what it does.

;;; Commentary:
;; meleme.el, yo!

;;; Code:

(defun meleme-display ()
  "Show your mode line and what it does."
  (interactive)
  (save-excursion
    (let ((list mode-line-format))
      (while list
        ;; Hm: Have to use print to make this work with with-output-to-temp-buffer.
        (print (format "%s: %s" (car list) (meleme-analyze (car list))))
        (print "----")
        (setq list (cdr list))))))

(defun meleme()
  "Show your mode line in a temporary buffer."
  (interactive)
  (with-output-to-temp-buffer "*meleme*"
    (meleme-display)))

(defun meleme-analyze (element)
  "Display what each ELEMENT of the mode format does."
  (interactive "S")
  (type-of element))
  ;; type-of does what I want, but I'll need to do something like this in the future.
  ;; (cond ((symbolp element)
  ;;        (quote "It's a symbol"))
  ;;       ((listp element)
  ;;        (quote "It's a list"))
  ;;       (t
  ;;        (quote "I don't know what that is."))))

(provide 'meleme)
;;; meleme ends here
