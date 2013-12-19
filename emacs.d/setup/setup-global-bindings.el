;; Org-mode keybindings
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c c") 'org-capture)

;; Jump to my org files easily
(define-key global-map "\C-coi" '(lambda () (interactive) (find-file "~/org/inbox.org")))
(define-key global-map "\C-con" '(lambda () (interactive) (find-file "~/org/next.org")))
(define-key global-map "\C-cos" '(lambda () (interactive) (find-file "~/org/someday.org")))
(define-key global-map "\C-cop" '(lambda () (interactive) (find-file "~/org/projects.org")))
(define-key global-map "\C-coj" '(lambda () (interactive) (find-file "~/org/journal.org")))

(provide 'setup-global-bindings)
