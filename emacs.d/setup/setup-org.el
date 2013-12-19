(require 'org)
(require 'org-habit)
(require 'org-checklist)
; (require 'org-helpers)
; (require 'org-export)

;; POMODORO SETTINGS
;; http://headhole.org/organisation/2012/08/22/org-mode-gtd-and-the-pomodoro-technique/
(require 'org-pomodoro)

;; sets the default workflow keywords and their faces
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!/!)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "SOMEDAY(o)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING")))

(setq org-priority-faces
      '((65 :foreground "#ff7000" :weight bold)
        (66 :foreground "#ffa060" :weight bold)
        (67 :foreground "#ffcca8" :weight bold)))

(setq org-todo-keyword-faces
      '(("SOMEDAY"   :foreground "#808080" :weight bold)
        ("NEXT"      :foreground "#e9c062" :weight bold)
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

;; The default agenda files. inbox.org is used only in custom agenda.
(setq org-agenda-files (list "~/org/next.org"
                             "~/org/projects.org"
                             "~/org/routines.org"
                             "~/org/workouts.org"
                             "~/org/goals.org"))

;; my org settings
(custom-set-variables
 '(org-startup-indented t)
 '(org-log-done t)
 '(org-catch-invisible-edits t)
 '(org-completion-use-ido t)
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
 '(org-clock-report-include-clocking-task t))

(setq org-refile-targets '(("~/org/next.org" :level . 1)
                           ("~/org/projects.org" :level . 1)
                           ("~/org/someday.org" :level . 1)
                           ("~/org/references.org" :level . 1)))

;; org-capture
(setq org-default-notes-file "~/org/inbox.org")
(setq org-capture-templates
      '(("t" "Todo" entry (file "~/org/inbox.org")
         "* TODO %?\n%U\nfrom:%a\n")
        ("m" "Meeting" entry (file "~/org/inbox.org")
         "* MEETING %?\n%U\n" :clock-in t :clock-resume t)
        ("n" "Note" entry (file "~/org/inbox.org")
         "* %? :note:\n%U\nfrom:%a\n" :clock-in t :clock-resume t)
        ("p" "Phone call" entry (file "~/org/inbox.org")
         "* PHONE %?\n%U" :clock-in t :clock-resume t)
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         (file "~/org/templates/journal.txt"))))

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

(provide 'setup-org)
