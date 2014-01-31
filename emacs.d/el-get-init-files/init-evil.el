(evil-mode 1)

;; mappings
(define-key evil-normal-state-map ";" 'evil-ex)
(define-key evil-normal-state-map ":" 'evil-repeat-find-char)

;; for org-mode
(evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle)
