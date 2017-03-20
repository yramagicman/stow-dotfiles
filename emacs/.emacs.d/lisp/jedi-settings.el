(add-hook
 'after-init-hook
 '(lambda ()

    ;; Looks like you need Emacs 24 for projectile
    (unless (< emacs-major-version 24)
      (require 'projectile)
      (projectile-global-mode))

    ;; Auto-complete
    (require 'auto-complete-config)
    (ac-config-default)


    ;; Jedi
    (require 'jedi)

    ;; (Many) config helpers follow

    ;; Alternative methods of finding the current project root
    ;; Method 1: basic
    (defun get-project-root (buf repo-file &optional init-file)
      "Just uses the vc-find-root function to figure out the project root.
       Won't always work for some directory layouts."
      (let* ((buf-dir (expand-file-name (file-name-directory (buffer-file-name buf))))
         (project-root (vc-find-root buf-dir repo-file)))
    (if project-root
        (expand-file-name project-root)
      nil)))

    ;; Method 2: slightly more robust
    (defun get-project-root-with-file (buf repo-file &optional init-file)
      "Guesses that the python root is the less 'deep' of either:
         -- the root directory of the repository, or
         -- the directory before the first directory after the root
            having the init-file file (e.g., '__init__.py'."

      ;; make list of directories from root, removing empty
      (defun make-dir-list (path)
        (delq nil (mapcar (lambda (x) (and (not (string= x "")) x))
                          (split-string path "/"))))
      ;; convert a list of directories to a path starting at "/"
      (defun dir-list-to-path (dirs)
        (mapconcat 'identity (cons "" dirs) "/"))
      ;; a little something to try to find the "best" root directory
      (defun try-find-best-root (base-dir buffer-dir current)
        (cond
         (base-dir ;; traverse until we reach the base
          (try-find-best-root (cdr base-dir) (cdr buffer-dir)
                              (append current (list (car buffer-dir)))))

         (buffer-dir ;; try until we hit the current directory
          (let* ((next-dir (append current (list (car buffer-dir))))
                 (file-file (concat (dir-list-to-path next-dir) "/" init-file)))
            (if (file-exists-p file-file)
                (dir-list-to-path current)
              (try-find-best-root nil (cdr buffer-dir) next-dir))))

         (t nil)))

      (let* ((buffer-dir (expand-file-name (file-name-directory (buffer-file-name buf))))
             (vc-root-dir (vc-find-root buffer-dir repo-file)))
        (if (and init-file vc-root-dir)
            (try-find-best-root
             (make-dir-list (expand-file-name vc-root-dir))
             (make-dir-list buffer-dir)
             '())
          vc-root-dir))) ;; default to vc root if init file not given

    ;; Set this variable to find project root
    (defvar jedi-config:find-root-function 'get-project-root-with-file)

    (defun current-buffer-project-root ()
      (funcall jedi-config:find-root-function
               (current-buffer)
               jedi-config:vcs-root-sentinel
               jedi-config:python-module-sentinel))

    (defun jedi-config:setup-server-args ()
      ;; little helper macro for building the arglist
      (defmacro add-args (arg-list arg-name arg-value)
        `(setq ,arg-list (append ,arg-list (list ,arg-name ,arg-value))))
      ;; and now define the args
      (let ((project-root (current-buffer-project-root)))

        (make-local-variable 'jedi:server-args)

        (when project-root
          (message (format "Adding system path: %s" project-root))
          (add-args jedi:server-args "--sys-path" project-root))

        (when jedi-config:with-virtualenv
          (message (format "Adding virtualenv: %s" jedi-config:with-virtualenv))
          (add-args jedi:server-args "--virtual-env" jedi-config:with-virtualenv))))

    ;; Use system python
    (defun jedi-config:set-python-executable ()
      (set-exec-path-from-shell-PATH)
      (make-local-variable 'jedi:server-command)
      (set 'jedi:server-command
           (list (executable-find "python") ;; may need help if running from GUI
                 (cadr default-jedi-server-command))))

    ;; Now hook everything up
    ;; Hook up to autocomplete
    (add-to-list 'ac-sources 'ac-source-jedi-direct)

    ;; Enable Jedi setup on mode start
    (add-hook 'python-mode-hook 'jedi:setup)

    ;; Buffer-specific server options
    (add-hook 'python-mode-hook
              'jedi-config:setup-server-args)
    (when jedi-config:use-system-python
      (add-hook 'python-mode-hook
                'jedi-config:set-python-executable))

    ;; And custom keybindings
    (defun jedi-config:setup-keys ()
      (local-set-key (kbd "M-.") 'jedi:goto-definition)
      (local-set-key (kbd "M-,") 'jedi:goto-definition-pop-marker)
      (local-set-key (kbd "M-?") 'jedi:show-doc)
      (local-set-key (kbd "M-/") 'jedi:get-in-function-call))

    ;; Don't let tooltip show up automatically
    (setq jedi:get-in-function-call-delay 10000000)
    ;; Start completion at method dot
    (setq jedi:complete-on-dot t)
    ;; Use custom keybinds
    (add-hook 'python-mode-hook 'jedi-config:setup-keys)

    ))

(provide 'jedi-settings)