(require 'helm)
(require 'helm-files)
(require 'helm-elisp)

(helm-mode 1)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-map (kbd "C-w") 'evil-delete-backward-word)
(define-key helm-find-files-map (kbd "C-w") 'evil-delete-backward-word)
