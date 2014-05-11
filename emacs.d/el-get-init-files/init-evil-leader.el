(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-leader/set-key
  "M" 'mu4e
  "Y" 'genki/pbcopy)

(evil-leader/set-key-for-mode 'org-mode
  "a" 'org-agenda-list
  "c" 'org-capture
  "j" 'org-next-item
  "k" 'org-previous-item
  "h" 'org-up-element
  ">" 'org-demote-subtree
  "<" 'org-promote-subtree)
