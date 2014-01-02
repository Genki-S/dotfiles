;; Global keybindings
(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "<f1>") 'help-command)

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
(define-key global-map "\C-cor" '(lambda () (interactive) (find-file "~/org/routines.org")))
(define-key global-map "\C-cog" '(lambda () (interactive) (find-file "~/org/goals.org")))
(define-key global-map "\C-cow" '(lambda () (interactive) (find-file "~/org/workouts.org")))
(define-key global-map "\C-cob" '(lambda () (interactive) (find-file "~/org/books.org")))

;; Override key bindings
;; http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs/1758639
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "M-h") 'backward-kill-word)
(define-key my-keys-minor-mode-map (kbd "C-c C-x C-i") 'org-pomodoro)
(define-key my-keys-minor-mode-map (kbd "C-c C-x C-o") 'org-pomodoro)

(define-minor-mode my-keys-minor-mode
                   "A minor mode so that my key settings override annoying major modes."
                   t " my-keys" 'my-keys-minor-mode-map)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(my-keys-minor-mode 1)

(provide 'setup-global-bindings)
