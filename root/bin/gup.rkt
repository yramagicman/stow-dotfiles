#lang racket
;(provide main)
(require racket/system)
(require racket/trace)
(require racket/place)

(define (execute-command proc-name)
  (define proc (find-executable-path proc-name))
  (lambda (args)
    (with-output-to-string
     (thunk (apply system* proc args)))))

(define home (path->string (find-system-path 'home-dir)))
(define repos (list home ".mutt" ".zprezto" ".zprezto/modules/zsh-aliases" ".password-store"))
(define git [find-executable-path "git"])

(define (makepath p)
  (if (not (equal? home p))
      (string->path (string-append home p))
      (string->path home)))

(define paths (map makepath repos))

(define (changes)
  (define ch (string-split ((execute-command "git") (list "status")) "\n" #:trim? #t))
  (define not-empty (filter
                     (lambda (x)
                       (and (not (string=? "" x)) (> (string-length x) (string-length "modified"))))
                     ch))
  (define return-value (filter
                        (lambda (y)
                          (string=? "modified" (substring y 1 (string-length "\tmodified"))))
                        not-empty))
  (map (lambda (z)
         (substring z 1)) return-value))

(define num-changes (length (changes)))

(define (show-changes)
  (string-append (string-join (changes)) (make-string 20 #\space)))

(define (check-status)
  (define commands
    '(("checkout" "-q" "master")
      ("rev-parse" "@")
      ("rev-parse" "@{u}")
      ("merge-base" "@" "@{u}")))
  (define result (map (execute-command "git") commands))
  (let ([local (second result)]
        [remote (third result)]
        [base (fourth result)])
    (cond
      ((string=? local remote) 0)
      ((string=? base remote) 1)
      ((string=? base local) -1)
      (else 2))))

(define (pull-push pull push)
  ((execute-command "git") (list "fetch"))
  (define stat (check-status))
  (cond
    ((not (= stat 0))
     (cond
       ((= stat -1) (pull))
       ((= stat 1) (push))
       (else ((execute-command "git" )  "diff" "HEAD" "master" "origin/HEAD" "origin/master"))))
    (else (show-changes))))

(define (pull)
  (let ([pass (list "pass" "git" "pull")]
        [git (list "git" "up")]
        [zprez (list (string->path (string-append home "bin/zupdate")))]
        [pwd (path->string (current-directory))])
    (cond
      ((string=? (string-append home "/.zprezto") pwd) ((execute-command (first zprez)) (rest zprez)))
      ((string=? (string-append home "/.password-store") pwd) ((execute-command (first pass)) (rest pass)))
      (else ((execute-command (first git)) (rest git))))))

(define (push)
  (let ([pass (list "pass" "git" "push")]
        [git (list "git" "push")]
        [pwd (path->string (current-directory))])
    (cond
      ((string=? (string-append home "/.password-store") pwd) ((execute-command (first pass)) (rest pass)))
      (else ((execute-command (first git)) (rest git))))))

(define (run-git-processes repo)
  (current-directory repo)
  (define cur-dir (path->string (current-directory)))
  (display (string-append cur-dir "..." (make-string 20 #\space) "\r"))
  (pull-push pull push))

(map displayln (map run-git-processes paths))
