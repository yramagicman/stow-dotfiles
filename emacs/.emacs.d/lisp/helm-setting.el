;;; package --- helm settings
;;; Commentary:
(require 'helm-config)

;;; Code:

(defun buflist nil
  "List buffers in helm."
  (interactive)
  (helm-buffers-list))

(defun find ( filename &optional wildcards )
  "Shadow vim find command, with helm.  FILENAME is the WILDCARDS."
  (interactive "F")
  (find-file filename wildcards))

(eval-after-load 'flycheck
   '(define-key flycheck-mode-map (kbd "C-c e") 'helm-flycheck))


(provide 'helm-setting)

;;; helm-setting.el ends here