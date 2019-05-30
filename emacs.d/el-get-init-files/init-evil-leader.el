(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-leader/set-key
  "M" 'mu4e
  "E" 'eval-buffer
  "V" 'genki/spawn-vim
  "Y" 'genki/copy
  "R" 'recover-this-file
  "oc" '(lambda () (interactive) (genki/open-browser "https://www.google.com/calendar/render")))

(evil-leader/set-key
  "a" '(lambda () (interactive) (org-agenda-list))
  "e" '(lambda () (interactive) (if (eq major-mode 'org-agenda-mode)
                                  (org-agenda-set-effort)
                                  (org-set-effort)))
  "t" '(lambda () (interactive) (if (eq major-mode 'org-agenda-mode)
                                  ; TODO: preserve time information of current SCHEDULED value
                                  (org-agenda-schedule nil "+0")
                                  (org-schedule nil "+0")))
  "c" 'org-capture
  "j" 'org-next-item
  "k" 'org-previous-item
  "h" 'org-up-element
  ">" 'org-demote-subtree
  "<" 'org-promote-subtree)

(evil-leader/set-key
  "pp" 'org-pomoboard/plan-tomorrow
  "pd" 'org-pomoboard/do-this-task-tomorrow
  "pt" 'org-pomoboard/open-dashboard-today
  "pF" 'org-pomoboard/finish-today)
