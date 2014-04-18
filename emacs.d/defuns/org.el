(defun genki/org-clock-current-task-to-tmux-statusline ()
  "Show current task on tmux statusline"
  (call-process "tmux"
                nil 0 nil
                "set" "status-right" org-clock-current-task))

(defun genki/org-clock-out-hook ()
  (call-process "tmux"
                nil 0 nil
                "set" "status-right" "NOT CLOCKING IN..."))
