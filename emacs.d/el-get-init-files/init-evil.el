;; Emacs is a great operating system, lacking only a decent editor

(evil-mode 1)

;; mappings
(define-key evil-normal-state-map ";" 'evil-ex)
(define-key evil-normal-state-map ":" 'evil-repeat-find-char)
(define-key evil-normal-state-map " " 'universal-argument)
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-normal-state-map (kbd "C-w C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-w C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-w C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-w C-l") 'evil-window-right)
(define-key evil-normal-state-map (kbd "C-s") 'save-buffer)

(define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)

;; for org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (setq evil-shift-width 2)))

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
  (kbd "r") 'org-agenda-redo
  (kbd "q") 'org-agenda-quit
  (kbd "C-s") 'org-save-all-org-buffers)

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

;; for yasnippet
(eval-after-load 'yasnippet
  '(progn
    (define-key evil-insert-state-map (kbd "C-k") 'yas-expand)))

;; for eww
(eval-after-load 'eww
  '(progn
     (evil-add-hjkl-bindings eww-mode-map 'normal
                             "q" 'quit-window)))
