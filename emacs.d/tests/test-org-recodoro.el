(require 'ert)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(el-get 'sync '(el-mock ert-expectations))
(require 'el-mock)
(require 'ert-expectations)

(load-file "~/.emacs.d/my-scripts/org-recodoro.el")

;; TODO: I want to mock these
(setq org-clock-current-task "TASK")
(setq fixed-time (current-time))
(setq formatted-fixed-time (format-time-string "%Y-%m-%dT%T%z" (current-time)))
(setq complete-mood "good")
(setq interrupt-reason "Gmail")

(defadvice expect (around expect-around)
           "setup and teardown"
           (setq current-pomodoro nil)
           ad-do-it)
(ad-activate 'expect)

;; start-pomodoro function
(expectations
  (desc "it creates pomodoro with title set as org-clock-current-task")
  (expect org-clock-current-task
          (progn
            (start-pomodoro)
            (gethash "title" current-pomodoro)))

  (desc "it creates pomodoro with created_at set as current-time")
  (expect formatted-fixed-time
          (with-mock (stub current-time => fixed-time)
                     (start-pomodoro)
                     (gethash "created_at" current-pomodoro))))

;; complete-pomodoro function
(expectations
  (desc "it sets completed_at as current-time")
  (expect formatted-fixed-time
          (with-mock (stub current-time => fixed-time)
                     (stub read-from-minibuffer => "1")
                     (start-pomodoro)
                     (complete-pomodoro)
                     (gethash "completed_at" current-pomodoro)))
  (desc "it does not set interrupted_at")
  (expect nil
          (with-mock (stub current-time => fixed-time)
                     (stub read-from-minibuffer => "1")
                     (start-pomodoro)
                     (complete-pomodoro)
                     (gethash "interrupted_at" current-pomodoro)))
  (desc "it creates reflection and set mood as good")
  (expect complete-mood
          (with-mock (stub read-from-minibuffer => "1")
                     (start-pomodoro)
                     (complete-pomodoro)
                     (gethash "mood"
                              (gethash "reflection" current-pomodoro))))
  (desc "it does not create interruption")
  (expect nil
          (with-mock (stub read-from-minibuffer => "1")
                     (start-pomodoro)
                     (complete-pomodoro)
                     (gethash "interruption" current-pomodoro))))

;; interrupt-pomodoro function
(expectations
  (desc "it sets interrupted_at as current-time")
  (expect formatted-fixed-time
          (with-mock (stub current-time => fixed-time)
                     (stub read-from-minibuffer => interrupt-reason)
                     (start-pomodoro)
                     (interrupt-pomodoro)
                     (gethash "interrupted_at" current-pomodoro)))
  (desc "it does not set completed_at")
  (expect nil
          (with-mock (stub current-time => fixed-time)
                     (stub read-from-minibuffer => interrupt-reason)
                     (start-pomodoro)
                     (interrupt-pomodoro)
                     (gethash "completed_at" current-pomodoro)))
  (desc "it creates interruption and set reason as interrupt-reason")
  (expect interrupt-reason
          (with-mock (stub read-from-minibuffer => interrupt-reason)
                     (start-pomodoro)
                     (interrupt-pomodoro)
                     (gethash "reason"
                              (gethash "interruption" current-pomodoro))))
  (desc "it does not create reflection")
  (expect nil
          (with-mock (stub read-from-minibuffer => "1")
                     (start-pomodoro)
                     (interrupt-pomodoro)
                     (gethash "reflection" current-pomodoro))))
