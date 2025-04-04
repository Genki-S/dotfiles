(require 'org)
(require 'org-habit)
(require 'org-checklist)
(require 'org-id)
; (require 'org-helpers)
; (require 'org-export)

;; notification https://gist.github.com/jstewart/7664823
(defun osx-notification (title message)
  (call-process "osx-notification"
                nil 0 nil
                title message))

;; sets the default workflow keywords and their faces
(setq org-todo-keywords
      '((sequence "TODO(t)" "DOING(n)" "|" "DONE(d!/!)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "DELEGATED(l@/!)" "CANCELLED(c@/!)" "PHONE" "MEETING")
        (sequence "DONT(o)" "|" "DIDNT(i!/!)")))

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
                      ("@office" . ?o)
                      ("@home" . ?h)
                      ("@errand" . ?e)
                      (:endgroup . nil)
                      (:startgroup . nil)
                      ("job" . ?j)
                      ("dotfiles" . ?d)
                      ("learning" . ?l)
                      ("social" . ?s)
                      (:endgroup . nil)))

;; The default agenda files.
(setq org-agenda-files (list "~/org/inbox.org"
                             "~/org/next.org"
                             "~/org/someday.org"
                             "~/org/scheduled.org"
                             "~/org/projects.org"
                             "~/org/routines.org"
                             "~/org/habits.org"
                             "~/org/books.org"
                             "~/org/workouts.org"
                             "~/org/journal.org"
                             "~/org/archives.org"
                             "~/org/checklist.org"
                             "~/org/goals.org"))
;; Create agenda files if not exist
(dolist (file org-agenda-files)
  (unless (file-exists-p file)
    (write-region "" nil file)))

(setq org-agenda-custom-commands
      `(("R" . "for reporting")
        ("Rd" "Daily report" agenda ""
         ((org-agenda-ndays 1)
          (org-agenda-archives-mode t)
          (org-agenda-entry-types '(:closed))
          (org-agenda-with-colors nil))
         (,(concat "~/org/reports/" (format-time-string "%Y-%m-%d") ".html")))))

;; my org settings
(custom-set-variables
 '(org-global-properties
    '(("Effort_ALL" . "0 0:01 0:05 0:10 0:30 1:00 1:30 2:00 2:30 3:00 3:30 4:00 4:30 5:00")))
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
 ;; Generate unique id for each node for linking purpose
 '(org-id-link-to-org-use-id t)
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
 ;; "Effort" (as noted in http://orgmode.org/manual/Effort-estimates.html) does not work actually.
 ;; "EFFORT" does. (for homebrew installed emacs 22.1.1 and 24.5.1, at least)
 '(org-columns-default-format "%50ITEM(Task) %20SCHEDULED %20EFFORT{:} %10CLOCKSUM")
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
                           ("~/org/scheduled.org" :maxlevel . 9)
                           ("~/org/waiting.org" :maxlevel . 9)
                           ("~/org/goals.org" :maxlevel . 9)
                           ("~/org/workouts.org" :maxlevel . 9)
                           ("~/org/routines.org" :maxlevel . 9)
                           ("~/org/habits.org" :maxlevel . 9)
                           ("~/org/books.org" :maxlevel . 9)
                           ("~/org/archives.org" :maxlevel . 9)
                           ("~/org/spark.org" :maxlevel . 9)
                           ("~/org/references.org" :maxlevel . 9)))

;; org-capture
(setq org-default-notes-file "~/org/inbox.org")
(setq org-capture-templates
      '(("t" "Todo" entry (file "~/org/inbox.org")
         "* TODO %?\n%U\n** Why do this?\n")
        ("i" "Issue" entry (file "~/org/inbox.org")
         (file "~/org/templates/jira_issue.txt"))
        ("f" "Failure" entry (file "~/org/inbox.org")
         (file "~/org/templates/failure_reflection.txt"))
        ("m" "Meeting" entry (file "~/org/inbox.org")
         "* MEETING %?\n%U\n** References\n** Learnings\n")
        ("n" "Note" entry (file "~/org/inbox.org")
         "* %?  :note:\n%U\n")
        ("q" "Question" entry (file "~/org/inbox.org")
         "* %?  :question:\n%U\n")
        ("p" "Phone call" entry (file "~/org/inbox.org")
         "* PHONE %?\n%U")
        ("r" "respond" entry (file "~/org/inbox.org")
         "* TODO Respond to %a\nSCHEDULED: %t\n%U\n" :immediate-finish t)
        ("s" "Spark" entry (file "~/org/spark.org")
         "* TODO %? :idea:\n")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         (file "~/org/templates/journal.txt"))
        ("w" "Weekly Review" entry (file+datetree "~/org/journal.org")
         (file "~/org/templates/weekly_review.txt"))
        ("7" "750 words" entry (file+datetree "~/org/journal.org")
         "* %?\n%U" :clock-in t :clock-resume t)))


;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)

(setq require-final-newline t)

(custom-set-faces
 '(org-mode-line-clock ((t (:foreground "red" :box (:line-width -1 :style released-button)))) t))

(setq org-plantuml-jar-path (concat vendor-dir "/plantuml.jar"))

;; MobileOrg
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/mobile-inbox.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;; Keybindings
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c c") 'org-capture)

;; Overrides
;; only org-mode, not org-agenda-mode (TODO: implement genki/org-agenda-schedule-subtree)
(define-key org-mode-map (kbd "C-c C-s") 'genki/org-schedule-subtree)

;; Jump to my org files easily
(define-key global-map "\C-coa" '(lambda () (interactive) (find-file "~/org/archives.org")))
(define-key global-map "\C-cod" '(lambda () (interactive) (find-file "~/org/dashboard.org")))
(define-key global-map "\C-coi" '(lambda () (interactive) (find-file "~/org/inbox.org")))
(define-key global-map "\C-con" '(lambda () (interactive) (find-file "~/org/next.org")))
(define-key global-map "\C-cos" '(lambda () (interactive) (find-file "~/org/someday.org")))
(define-key global-map "\C-coS" '(lambda () (interactive) (find-file "~/org/scheduled.org")))
(define-key global-map "\C-cop" '(lambda () (interactive) (find-file "~/org/projects.org")))
(define-key global-map "\C-coj" '(lambda () (interactive) (find-file "~/org/journal.org")))
(define-key global-map "\C-cor" '(lambda () (interactive) (find-file "~/org/routines.org")))
(define-key global-map "\C-coh" '(lambda () (interactive) (find-file "~/org/habits.org")))
(define-key global-map "\C-cog" '(lambda () (interactive) (find-file "~/org/goals.org")))
(define-key global-map "\C-cow" '(lambda () (interactive) (find-file "~/org/workouts.org")))
(define-key global-map "\C-cob" '(lambda () (interactive) (find-file "~/org/books.org")))
(define-key global-map "\C-coc" '(lambda () (interactive) (find-file "~/org/checklist.org")))

;; org-pomodoro
(defvar lorem "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
(define-key global-map "\C-cp" 'org-pomodoro)

(defun play-sound-with-ffplay-bg (sound)
  "Play sound file with ffplay in background"
  (if sound
    (start-process "org-pomodoro-ffplay" "foo" "ffplay" "-nodisp" "-autoexit" "-volume" "100" sound)))

(add-hook 'org-pomodoro-started-hook
          (lambda ()
            (play-sound-with-ffplay-bg (getenv "ORG_POMODORO_START_SOUND"))))
(add-hook 'org-pomodoro-finished-hook
          (lambda ()
            (call-process "activate-org")
            (play-sound-with-ffplay-bg (getenv "ORG_POMODORO_FINISH_SOUND"))
            (call-process "pushover" nil nil nil "org-pomodoro: Pomodoro Finished!")
            (call-process "my-notification" nil nil nil "Pomodoro Finished!" (concat "\nPomodoro finished, go back to your emacs.\n\n\n\n\n" lorem) "--urgency" "critical")))
(add-hook 'org-pomodoro-killed-hook
          (lambda ()
            (call-process "activate-org")
            (call-process "pushover" nil nil nil "org-pomodoro: Pomodoro Killed!")
            (call-process "my-notification" nil nil nil "Pomodoro Killed!" (concat "\nPomodoro killed, go back to your emacs.\n\n\n\n\n" lorem) "--urgency" "critical")))
(add-hook 'org-pomodoro-break-finished-hook
          (lambda ()
            (call-process "activate-org")
            (call-process "pushover" nil nil nil "org-pomodoro: Pomodoro break finished!")
            (call-process "my-notification" nil nil nil "Pomodoro break finished!" (concat "\nPomodoro break finished, go back to your emacs.\n\n\n\n\n" lorem) "--urgency" "critical")))
; (run-at-time nil 180 'genki/org-notify-no-pomodoro)

;; org-habit
;; show habits in the future
(setq org-habit-show-habits-only-for-today nil)

;; for org backup
(run-at-time "00:58" 3600 'org-save-all-org-buffers)

;; org-mode hooks
;; agenda evil settings
(add-hook 'org-agenda-mode-hook 'evil-normal-state)
;; start with insert state in capture modes
(add-hook 'org-capture-mode-hook 'genki/org-capture-buffer-setup)
;; notify home assistant for journal finish
;; not using 'org-capture-prepare-finalize-hook because it fails if the
;; capture buffer lives long before closed for unknown reason
(add-hook 'org-capture-mode-hook
          (lambda ()
            (when (equal (org-capture-get :key) "j")
              (genki/home-assistant-webhook (getenv "HOME_ASSISTANT_JOURNAL_FINISH_WEBHOOK_ID")))))

;; auto sync with MobileOrg
; TODO make this run in background
; (add-hook 'after-init-hook 'org-mobile-pull)
; (add-hook 'kill-emacs-hook 'org-mobile-push)
(add-hook 'org-clock-in-hook 'genki/org-clock-current-task-to-tmux-statusline)
(add-hook 'org-clock-out-hook 'genki/org-clock-current-task-to-tmux-statusline)
(run-at-time nil 1 'genki/org-clock-current-task-to-tmux-statusline)

(provide 'setup-org)
