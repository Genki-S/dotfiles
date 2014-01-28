;; Global keybindings
(define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "<f1>") 'help-command)

;; summon-vim
(define-key global-map "\C-cv" '(lambda () (interactive) (genki/summon-vim)))

;; Override key bindings
;; http://stackoverflow.com/questions/683425/globally-override-key-binding-in-emacs/1758639
(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map (kbd "M-h") 'backward-kill-word)

(define-minor-mode my-keys-minor-mode
                   "A minor mode so that my key settings override annoying major modes."
                   t " my-keys" 'my-keys-minor-mode-map)

(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0))

(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(my-keys-minor-mode 1)

(provide 'setup-global-bindings)
