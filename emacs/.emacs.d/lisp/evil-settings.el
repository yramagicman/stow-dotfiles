(evil-mode 1)
(require 'evil-surround)
(global-evil-surround-mode 1)
(global-evil-visualstar-mode)
(defun evil-map-key (key-str fn-quoted)
    "Map key for both insert and normal modes KEY-STR FN-QUOTED."
    (define-key evil-insert-state-map  (kbd key-str) fn-quoted)
    (define-key evil-normal-state-map  (kbd key-str) fn-quoted)
    (define-key evil-replace-state-map (kbd key-str) fn-quoted)
    (define-key evil-visual-state-map  (kbd key-str) fn-quoted))

(define-key evil-visual-state-map  (kbd "TAB") 'evilmi-jump-items)
(define-key evil-normal-state-map  (kbd "TAB") 'evilmi-jump-items)
(evil-map-key "C-S-z" 'evil-exit-emacs-state)
(evil-map-key "C-M-z" 'evil-emacs-state)
(evil-map-key "M-c" 'evil-force-normal-state)
(evil-map-key "M-s" 'save-buffer)
(evil-map-key "C-q" 'kill-emacs)
(evil-map-key "M-q" 'kill-emacs)
(evil-map-key "C-s" 'save-buffer)
(evil-map-key "C-n" 'evil-normal-state)
(evil-map-key "M-n" 'evil-normal-state)
(evil-map-key "C-S-e" 'eval-buffer)
(evil-map-key "C-h" 'evil-window-left)
(evil-map-key "C-j" 'evil-window-down)
(evil-map-key "C-k" 'evil-window-up)
(evil-map-key "C-l" 'evil-window-right)
; Kill the annoyance of typing the wrong key
(global-unset-key (kbd "C-x h"))
(define-key evil-normal-state-map (kbd "Q") 'fill-paragraph)
;(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
;             [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
;             [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
;             [mouse-5] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
;             [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
;  (global-unset-key k))

(defun evil-font-increase nil
  (interactive)
  (text-scale-adjust 0.5))

(defun evil-font-decrease nil
  (interactive)
  (text-scale-adjust -0.5))

(defun evil-font-reset nil
  (interactive)
  (text-scale-set 0))

(require 'evil-numbers)
(evil-map-key "C-a" 'evil-numbers/inc-at-pt)
(evil-map-key "C-x" 'evil-numbers/dec-at-pt)
(evil-map-key "C-+" 'evil-font-increase)
(evil-map-key "C-=" 'evil-font-increase)
(evil-map-key "C--" 'evil-font-decrease)
(evil-map-key "C-0" 'evil-font-reset)

(require 'general)

(setq general-default-prefix ",")
(general-evil-setup t)

(nmap "ss" 'save-buffer
      "m" 'save-buffer
      "wq" 'save-buffers-kill-terminal
      "z" 'narrow-to-defun
      "a" 'widen
      "o" 'evil-insert-line
      "r" 'visual-line-mode)
(vmap "z" 'narrow-to-region
      "m" 'evil-normal-state)


(require 'evil-escape)
(setq-default evil-escape-key-sequence ",m")
(setq evil-escape-unordered-key-sequence t)
(evil-escape-mode)
(setq-default evil-escape-delay 0.2)




(provide 'evil-settings)