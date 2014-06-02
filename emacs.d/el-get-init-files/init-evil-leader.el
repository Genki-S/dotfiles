(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-leader/set-key
  "M" 'mu4e
  "E" 'eval-buffer
  "V" 'genki/spawn-vim
  "Y" 'genki/pbcopy)

(evil-leader/set-key
  "a" 'org-agenda-list
  "c" 'org-capture
  "j" 'org-next-item
  "k" 'org-previous-item
  "h" 'org-up-element
  ">" 'org-demote-subtree
  "<" 'org-promote-subtree)

(evil-leader/set-key
  "pp" 'org-pomoboard/plan-tomorrow
  "pd" 'org-pomoboard/do-this-task-tomorrow
  "pt" 'org-pomoboard/open-dashboard-today)
