(global-evil-leader-mode)
(evil-leader/set-leader ",")

(evil-leader/set-key-for-mode 'org-mode
  ">" 'org-demote-subtree
  "<" 'org-promote-subtree)
