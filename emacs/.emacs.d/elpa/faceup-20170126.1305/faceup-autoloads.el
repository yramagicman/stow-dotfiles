;;; faceup-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "faceup" "faceup.el" (22732 51393 754823 946000))
;;; Generated autoloads from faceup.el

(autoload 'faceup-view-buffer "faceup" "\
Display the faceup representation of the selected buffer.

\(fn)" t nil)

(autoload 'faceup-write-file "faceup" "\
Save the faceup representation of the current buffer to the file FILE-NAME.

Unless a name is given, the file will be named xxx.faceup, where
xxx is the file name associated with the buffer.

If optional second arg CONFIRM is non-nil, this function
asks for confirmation before overwriting an existing file.
Interactively, confirmation is required unless you supply a prefix argument.

\(fn &optional FILE-NAME CONFIRM)" t nil)

(autoload 'faceup-render-view-buffer "faceup" "\
Convert BUFFER containing Faceup markup to a new buffer and display it.

\(fn &optional BUFFER)" t nil)

(autoload 'faceup-clean-buffer "faceup" "\
Remove faceup markup from buffer.

\(fn)" t nil)

(autoload 'faceup-defexplainer "faceup" "\
Defines an Ert explainer function for FUNCTION.

FUNCTION must return an explanation when the test fails and
`faceup-test-explain' is set.

\(fn FUNCTION)" nil t)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; faceup-autoloads.el ends here
