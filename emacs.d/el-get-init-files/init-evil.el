(evil-mode 1)

;; mappings
(define-key evil-normal-state-map ";" 'evil-ex)
(define-key evil-normal-state-map ":" 'evil-repeat-find-char)

(define-key evil-normal-state-map ",;" 'eval-expression)
(define-key evil-normal-state-map ",x" 'execute-extended-command)

;; for org-mode
(evil-define-key 'normal org-mode-map
  (kbd "RET") 'org-ctrl-c-ctrl-c
  (kbd "TAB") 'org-cycle)

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

;; esc quits everything (https://github.com/davvil/.emacs.d/blob/master/init.el)
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)
