(defun genki/tmux-set-status-right (message)
  (call-process "tmux"
                nil 0 nil
                "set" "status-right" message))

(defun genki/org-clock-current-task-to-tmux-statusline ()
  "Show current task on tmux statusline"
  (genki/tmux-set-status-right (or org-clock-current-task "CAPTURE")))

(defun genki/org-clock-out-hook ()
  (genki/tmux-set-status-right "NOT CLOCKING IN..."))
