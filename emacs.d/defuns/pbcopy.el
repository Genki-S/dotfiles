;; http://apple.stackexchange.com/questions/85222/configure-emacs-to-cut-and-copy-text-to-mac-os-x-clipboard
(defun genki/pbcopy ()
  "Copy region into OSX clipboard"
  (interactive)
  (shell-command-on-region (region-beginning) (region-end) "reattach-to-user-namespace pbcopy"))
