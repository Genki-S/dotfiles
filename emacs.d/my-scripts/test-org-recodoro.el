(require 'ert)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(el-get 'sync '(el-mock ert-expectations))
(require 'el-mock)
(require 'ert-expectations)

(load-file "org-recodoro.el")

;; TODO: I want to mock these
(setq org-clock-current-task "TASK")
(setq fixed-time (current-time))
(setq complete-mood "good")
(setq interrupt-reason "Gmail")

(defadvice expect (around expect-around)
           "setup and teardown"
           (setq current-pomodoro nil)
           ad-do-it)

(expectations
  (desc "start-pomodoro creates valid pomodoro")
  (expect org-clock-current-task
          (progn
            (start-pomodoro)
            (gethash "title" current-pomodoro)))
  (expect fixed-time
          (with-mock (stub current-time => fixed-time)
                     (start-pomodoro)
                     (gethash "created_at" current-pomodoro)))

  (desc "complete-pomodoro sets proper attributes to current-pomodoro")
  (expect complete-mood
          (with-mock (stub read-from-minibuffer => "1")
                     (start-pomodoro)
                     (complete-pomodoro)
                     (gethash "mood"
                              (gethash "reflection" current-pomodoro))))
  ;; it does not set interruption
  (expect nil
          (with-mock (stub read-from-minibuffer => "1")
                     (start-pomodoro)
                     (complete-pomodoro)
                     (gethash "interruption" current-pomodoro)))

  (desc "interrupt-pomodoro sets proper attributes to current-pomodoro")
  (expect interrupt-reason
          (with-mock (stub read-from-minibuffer => interrupt-reason)
                     (start-pomodoro)
                     (interrupt-pomodoro)
                     (gethash "reason"
                              (gethash "interruption" current-pomodoro))))
  ;; it does not set reflection
  (expect nil
          (with-mock (stub read-from-minibuffer => "1")
                     (start-pomodoro)
                     (interrupt-pomodoro)
                     (gethash "reflection" current-pomodoro))))
