(setq genki-org-current-task "NOT CLOCKING IN...")
(defun genki/tmux-set-status-right (text)
  (call-process "tmux"
                nil 0 nil
                "set" "status-right" text))

(defun genki/org-clock-current-task-to-tmux-statusline ()
  (if (org-clocking-p)
      (if org-clock-current-task
          (setq genki-org-current-task org-clock-current-task)
          (setq genki-org-current-task "CAPTURING"))
        (setq genki-org-current-task "NOT CLOCKING IN..."))
      (setq genki-tmux-status-text
            (if (boundp 'org-pomodoro-state)
              (cl-case org-pomodoro-state
                       (:none genki-org-current-task)
                       (t (concat "[" (org-pomodoro-format-seconds) "] " genki-org-current-task)))
              genki-org-current-task))
      (genki/tmux-set-status-right genki-tmux-status-text))

(defun genki/org-notify-no-pomodoro ()
  (if (fboundp 'org-pomodoro-active-p)
    (if (org-pomodoro-active-p)
      ()
      (call-process "my-notification" nil nil nil "Pomodoro is not active!" "\nPomodoro is not active, gather yourself and start one!" "--urgency" "critical" "--expire-time" "5000"))))

(defun genki/org-capture-buffer-setup ()
  ;; things always done
  (evil-insert 1)
  ;; things done according to capture template
  (when (stringp read-char-exclusive-last-input)
    (pcase read-char-exclusive-last-input
      ("7" (genki/org-capture-750-words-setup)))))

(defun genki/org-capture-750-words-setup ()
  (wc-mode)
  (wc-set-word-goal 10))

(defun genki/org-schedule-subtree ()
  (interactive)
  (call-interactively 'org-schedule)
  (let ((time (org-get-scheduled-time (point))))
    (org-map-tree
      (lambda () (progn
                   (if (org-entry-is-todo-p) (org-schedule nil time)))))))

; http://stackoverflow.com/questions/6997387/how-to-archive-all-the-done-tasks-using-a-single-command/7015844#7015844
(defun genki/org-archive-done-tasks ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'agenda)
  (org-map-entries 'org-archive-subtree "/CANCELLED" 'agenda))
