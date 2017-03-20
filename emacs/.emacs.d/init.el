;;; package --- .emacs
;;; Commentary:
;;; Code:

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(require 'cl)
(require 'package)
(require 'iso-transl)
(add-to-list 'load-path
             (expand-file-name "lisp" user-emacs-directory))

(defvar cfg-var:packages)
(setq cfg-var:packages '(
             evil
             base16-theme
             evil-escape
             evil-matchit
             evil-surround
             evil-visualstar
             evil-nerd-commenter
             evil-numbers
             auto-complete
             relative-line-numbers
             git-commit
             muttrc-mode
             projectile
             racket-mode
             clojure-mode
             epc
             magit
             general
             sass-mode
             scss-mode
             key-chord
             markdown-mode
             ac-php
             web-mode
             helm
             helm-flycheck
             helm-git
             helm-fuzzy-find
             helm-projectile
             ac-php-core
             php-eldoc
             flycheck
             jedi))

(defun cfg:install-packages ()
  "Install packages from list."
    (let ((pkgs (remove-if #'package-installed-p cfg-var:packages)))
        (when pkgs
            (message "%s" "Emacs refresh packages database...")
            (package-refresh-contents)
            (message "%s" " done.")
            (dolist (p cfg-var:packages)
                (package-install p)))))

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(cfg:install-packages)
(require 'org)
(require 'evil)
(require 'auto-complete)
;(require 'key-chord)
(require 'ido)

(ido-mode t)
(setq custom-file
      (expand-file-name "lisp/custom.el" user-emacs-directory))
(load custom-file)

(setq-default word-wrap t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(global-relative-line-numbers-mode)
(global-auto-complete-mode 1)


(defun myterm (&optional prog)
  "Run term with PROG or zsh."
  (interactive)
  (term (or prog "/usr/bin/zsh")))
(global-set-key "\C-ct" 'myterm)
(global-visual-line-mode t)
(setq backup-inhibited t)
(setq auto-save-default nil)




(require 'evil-settings)

;; Global Jedi config vars

(defvar jedi-config:use-system-python nil
  "Will use system python and active environment for Jedi server.
May be necessary for some GUI environments (e.g., Mac OS X)")

(defvar jedi-config:with-virtualenv nil
  "Set to non-nil to point to a particular virtualenv.")

(defvar jedi-config:vcs-root-sentinel ".git")

(defvar jedi-config:python-module-sentinel "__init__.py")

;; Helper functions

;; Small helper to scrape text from shell output
(defun get-shell-output (cmd)
  (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string cmd)))

;; Ensure that PATH is taken from shell
;; Necessary on some environments without virtualenv
;; Taken from: http://stackoverflow.com/questions/8606954/path-and-exec-path-set-but-emacs-does-not-find-executable
(defun set-exec-path-from-shell-PATH ()
  "Set up Emacs' `exec-path' and PATH environment variable to match that used by the user's shell."
  (interactive)
  (let ((path-from-shell (get-shell-output "$SHELL --login -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(require 'jedi-settings)

(require 'ispell)
;; Find dictionary
(executable-find "aspell")
  (setq ispell-program-name "aspell")
  ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))

(require 'user_hooks)
(require 'helm-setting)

(require 'server)
(unless (server-running-p) (server-start))
(provide 'init)
;;; init ends here


(defun worklist (&optional file)
    (interactive)
    (find-file "~/Dropbox/org/worklist.org"))
(global-set-key (kbd "C-S-w") 'worklist)

(require 'undohist)
(undohist-initialize)
(put 'narrow-to-region 'disabled nil)
