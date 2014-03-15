(evil-mode 1)

;; mappings
(define-key evil-normal-state-map ";" 'evil-ex)
(define-key evil-normal-state-map ":" 'evil-repeat-find-char)

(define-key evil-normal-state-map ",;" 'eval-expression)
(define-key evil-normal-state-map ",x" 'execute-extended-command)

;; for org-mode
(evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)

;; see http://www.gnu.org/software/emacs/manual/html_node/org/Agenda-commands.html
(evil-define-key 'normal org-agenda-mode-map
  (kbd "SPACE") 'org-agenda-show-and-scroll-up
  (kbd "TAB") 'org-agenda-goto
  (kbd "RET") 'org-agenda-switch-to
  (kbd "C-c C-o") 'org-agenda-open-link
  (kbd "<") 'org-agenda-filter-by-category
  (kbd "t") 'org-agenda-todo
  (kbd "C-c C-w") 'org-agenda-refile
  (kbd "T") 'org-agenda-show-tags
  (kbd ":") 'org-agenda-set-tags
  (kbd ",") 'org-agenda-priority
  (kbd "P") 'org-agenda-show-priority
  (kbd "I") 'org-agenda-clock-in
  (kbd "O") 'org-agenda-clock-out
  (kbd "J") 'org-agenda-clock-goto
  (kbd "q") 'org-agenda-quit)
