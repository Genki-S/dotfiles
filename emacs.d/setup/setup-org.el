(require 'org)
(require 'org-habit)
(require 'org-checklist)
; (require 'org-helpers)
; (require 'org-export)

;; POMODORO SETTINGS
;; http://headhole.org/organisation/2012/08/22/org-mode-gtd-and-the-pomodoro-technique/
(require 'org-pomodoro)

;; for tmux status bar
(defun write-org-pomodoro-state (state)
  (with-temp-buffer
    (insert (concat state "\n"
                    (format-time-string "%s") "\n"))
    (when (file-writable-p "~/.org-pomodoro-status")
      (write-region (point-min) (point-max) "~/.org-pomodoro-status")
      (call-process "tmux-all-session-do" nil 0 nil "refresh-client" "-S"))))

;; notification https://gist.github.com/jstewart/7664823
(defun notify-osx (title message)
  (call-process "osx-alert"
                nil 0 nil
                title message))

(add-hook 'org-pomodoro-started-hook
          (lambda ()
            (write-org-pomodoro-state (symbol-name org-pomodoro-state))))
(add-hook 'org-pomodoro-finished-hook
          (lambda ()
            (write-org-pomodoro-state (symbol-name org-pomodoro-state))
            (notify-osx "Pomodoro completed!" "Time for a break.")))
(add-hook 'org-pomodoro-short-break-finished-hook
          (lambda ()
            (write-org-pomodoro-state ":none")
            (notify-osx "Pomodoro Short Break Finished" "Ready for Another?")))
(add-hook 'org-pomodoro-long-break-finished-hook
          (lambda ()
            (write-org-pomodoro-state ":none")
            (notify-osx "Pomodoro Long Break Finished" "Ready for Another?")))
(add-hook 'org-pomodoro-killed-hook
          (lambda ()
            (write-org-pomodoro-state ":none")
            (notify-osx "Pomodoro Killed" "One does not simply kill a pomodoro!")))

;; sets the default workflow keywords and their faces
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(n)" "|" "DONE(d!/!)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "DELEGATED(l@/!)" "CANCELLED(c@/!)" "PHONE" "MEETING")))

(setq org-priority-faces
      '((65 :foreground "#ff7000" :weight bold)
        (66 :foreground "#ffa060" :weight bold)
        (67 :foreground "#ffcca8" :weight bold)))

(setq org-todo-keyword-faces
      '(("SOMEDAY"   :foreground "#808080" :weight bold)
        ("DOING"      :foreground "#e9c062" :weight bold)
        ("WAITING"   :foreground "#fd9b3b" :weight bold)
        ("HOLD"      :foreground "#9b859d" :weight bold)
        ("CANCELLED" :foreground "#9eb9a7" :weight bold)))

(setq org-tag-alist '((:startgroup . nil)
                      ("@work" . ?w)
                      ("@home" . ?h)
                      ("@univ" . ?u)
                      (:endgroup . nil)
                      (:startgroup . nil)
                      ("Q1" . ?1)
                      ("Q2" . ?2)
                      ("Q3" . ?3)
                      ("Q4" . ?4)
                      (:endgroup . nil)))

;; The default agenda files.
(setq org-agenda-files (list "~/org/inbox.org"
                             "~/org/next.org"
                             "~/org/someday.org"
                             "~/org/projects.org"
                             "~/org/routines.org"
                             "~/org/books.org"
                             "~/org/workouts.org"
                             "~/org/goals.org"))

(setq org-agenda-custom-commands
      `(("R" . "for reporting")
        ("Rd" "Daily report" agenda ""
         ((org-agenda-ndays 1)
          (org-agenda-archives-mode t)
          (org-agenda-entry-types '(:closed))
          (org-agenda-with-colors nil))
         (,(concat "~/org/reports/" (format-time-string "%Y-%m-%d") ".html")))))

;; agenda evil settings
(add-hook 'org-agenda-mode-hook 'evil-normal-state)

;; my org settings
(custom-set-variables
 '(org-startup-indented t)
 '(org-startup-truncated nil)
 '(org-log-done t)
 '(org-catch-invisible-edits t)
 ;; Better completion
 '(org-completion-use-ido t)
 '(org-outline-path-complete-in-steps nil)
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-include-diary t)
 '(org-agenda-window-setup 'current-window)
 '(org-agenda-repeating-timestamp-show-all t)
 ;; Show all agenda dates - even if they are empty
 '(org-agenda-show-all-dates t)
 ;; Remove completed deadline tasks from the agenda view
 '(org-agenda-skip-deadline-if-done t)
 ;; Remove completed scheduled tasks from the agenda view
 '(org-agenda-skip-scheduled-if-done t)
 ;; Remove completed items from search results
 '(org-agenda-skip-timestamp-if-done t)
 ;; Separate drawers for clocking and logs
 '(org-drawers (quote ("PROPERTIES" "LOGBOOK")))
 ;; Save clock data and state changes and notes in the LOGBOOK drawer
 '(org-log-into-drawer t)
 '(org-clock-into-drawer t)
 ;; Sometimes I change tasks I'm clocking quickly
 ;; this removes clocked tasks with 0:00 duration
 '(org-clock-out-remove-zero-time-clocks t)
 ;; Do not prompt to resume an active clock
 '(org-clock-persist-query-resume nil)
 ;; Include current clocking task in clock reports
 '(org-clock-report-include-clocking-task t)
 '(org-columns-default-format "%25ITEM %15SCHEDULED %6Effort{:} %8CLOCKSUM")
 ;; provide refile targets as paths, including the file name
 ;; (without directory) as level 1 of the path
 '(org-refile-use-outline-path 'file)
 ;; export settings
 '(org-export-with-toc nil)
 '(org-export-with-section-numbers nil)
 '(org-html-doctype "html5")
 '(org-html-html5-fancy t))

;; LaTeX setings
(require 'ox-html)
(require 'ox-latex)
(require 'ox-ascii)

(setq org-latex-to-pdf-process
      (list "latexmk -pdflatex='pdflatex -shell-escape -interaction nonstopmode -file-line-error -synctex=1' -pdf -bibtex %f"))

(add-to-list 'org-latex-classes
             '("article"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("koma-article"
               "\\documentclass{scrartcl}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-export-latex-listings 'minted)
(setq org-export-latex-minted-options
     '(("frame" "lines")
       ("fontsize" "\\scriptsize")
       ("linenos" "")))

;; reftex (http://nakkaya.com/2010/09/07/writing-papers-using-org-mode/)
(setq-default TeX-master t)
(setq reftex-default-bibliography
      (quote ("~/reftex.bib")))
(defun na-org-mode-reftex-setup ()
  (interactive)
  (load-library "reftex")
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all)))
(add-hook 'org-mode-hook 'na-org-mode-reftex-setup)

;; Refiling
(setq org-refile-targets '((nil :maxlevel . 9)
                           ("~/org/next.org" :maxlevel . 9)
                           ("~/org/projects.org" :maxlevel . 9)
                           ("~/org/someday.org" :maxlevel . 9)
                           ("~/org/waiting.org" :maxlevel . 9)
                           ("~/org/goals.org" :maxlevel . 9)
                           ("~/org/workouts.org" :maxlevel . 9)
                           ("~/org/routines.org" :maxlevel . 9)
                           ("~/org/books.org" :maxlevel . 9)
                           ("~/org/references.org" :maxlevel . 9)))

;; org-capture
(setq org-default-notes-file "~/org/inbox.org")
(setq org-capture-templates
      '(("t" "Todo" entry (file "~/org/inbox.org")
         "* TODO %?\n%U\nfrom:%a\n** Why do this?\n" :clock-in t :clock-resume t)
        ("m" "Meeting" entry (file "~/org/inbox.org")
         "* MEETING %?\n%U\n" :clock-in t :clock-resume t)
        ("n" "Note" entry (file "~/org/inbox.org")
         "* %? :note:\n%U\nfrom:%a\n" :clock-in t :clock-resume t)
        ("p" "Phone call" entry (file "~/org/inbox.org")
         "* PHONE %?\n%U" :clock-in t :clock-resume t)
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         (file "~/org/templates/journal.txt") :clock-in t :clock-resume t)
        ("7" "750 words" entry (file+datetree "~/org/journal.org")
         "* %?\n%U" :clock-in t :clock-resume t)))

; start with insert state in capture modes
(add-hook 'org-capture-mode-hook (lambda () (evil-append (point))))

;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)

(setq require-final-newline t)

(custom-set-faces
 '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))


;; org-babel
(org-babel-do-load-languages
 (quote org-babel-load-languages)
 '((emacs-lisp . t)
   (dot . t)
   (ditaa . t)
   (R . t)
   (python . t)
   (ruby . t)
   (gnuplot . t)
   (clojure . t)
   (sh . t)
   (ledger . t)
   (org . t)
   (plantuml . t)
   (latex . t)))

(setq org-plantuml-jar-path (concat vendor-dir "/plantuml.jar"))

;; MobileOrg
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/mobile-inbox.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;; auto sync
(add-hook 'after-init-hook 'org-mobile-pull)
(add-hook 'kill-emacs-hook 'org-mobile-push)

;; Keybindings
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c c") 'org-capture)

;; Jump to my org files easily
(define-key global-map "\C-cod" '(lambda () (interactive) (find-file "~/org/dashboard.org")))
(define-key global-map "\C-coi" '(lambda () (interactive) (find-file "~/org/inbox.org")))
(define-key global-map "\C-con" '(lambda () (interactive) (find-file "~/org/next.org")))
(define-key global-map "\C-cos" '(lambda () (interactive) (find-file "~/org/someday.org")))
(define-key global-map "\C-cop" '(lambda () (interactive) (find-file "~/org/projects.org")))
(define-key global-map "\C-coj" '(lambda () (interactive) (find-file "~/org/journal.org")))
(define-key global-map "\C-cor" '(lambda () (interactive) (find-file "~/org/routines.org")))
(define-key global-map "\C-cog" '(lambda () (interactive) (find-file "~/org/goals.org")))
(define-key global-map "\C-cow" '(lambda () (interactive) (find-file "~/org/workouts.org")))
(define-key global-map "\C-cob" '(lambda () (interactive) (find-file "~/org/books.org")))

;; org-pomodoro
(define-key global-map "\C-cp" 'org-pomodoro)

;; for org backup
(run-at-time "00:58" 3600 'org-save-all-org-buffers)

(provide 'setup-org)
