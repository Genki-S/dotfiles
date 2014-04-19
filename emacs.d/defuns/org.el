(defun genki/tmux-set-status-right ()
  (call-process "tmux"
                nil 0 nil
                "set" "status-right" genki-org-current-task))

(defun genki/org-clock-current-task-to-tmux-statusline ()
  (if (org-clocking-p)
      (if org-clock-current-task
          (setq genki-org-current-task org-clock-current-task)
          (setq genki-org-current-task "CAPTURING"))
        (setq genki-org-current-task "NOT CLOCKING IN..."))
      (genki/tmux-set-status-right))
