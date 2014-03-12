(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-leader/set-key-for-mode 'org-mode
  "j" 'org-next-item
  "k" 'org-previous-item
  "h" 'org-up-element
  ">" 'org-demote-subtree
  "<" 'org-promote-subtree)
