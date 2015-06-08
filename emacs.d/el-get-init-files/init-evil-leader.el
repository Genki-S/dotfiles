(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-leader/set-key
  "M" 'mu4e
  "E" 'eval-buffer
  "V" 'genki/spawn-vim
  "Y" 'genki/pbcopy
  "oc" '(lambda () (interactive) (genki/open-browser "https://www.google.com/calendar/render")))

(evil-leader/set-key
  "a" '(lambda () (interactive) (org-agenda-list) (org-agenda-columns) (evil-normal-state))
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
