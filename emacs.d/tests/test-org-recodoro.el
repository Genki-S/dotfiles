(require 'ert)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(el-get 'sync '(el-mock ert-expectations))
(require 'el-mock)
(require 'ert-expectations)

(load-file "~/.emacs.d/my-scripts/org-recodoro.el")

;; TODO: I want to mock these
(setq pomodoro-goal 5)
(setq org-clock-current-task "TASK")
(setq fixed-time (current-time))
(setq formatted-fixed-time (format-time-string "%Y-%m-%dT%T%z" (current-time)))
(setq formatted-fixed-date (format-time-string "%Y-%m-%d" (current-time)))
(setq complete-mood "good")
(setq interrupt-reason "Gmail")

;; FIXME: this is dirty
(setq recodoro-save-dir "~/.org-recodoro-test")
(make-directory recodoro-save-dir t)

(defadvice expect (around expect-around)
           "setup and teardown"
           (setq current-pomodoro nil)
           ad-do-it)
(ad-activate 'expect)

;; start-day function
(expectations
  (desc "it creates a day with current date")
  (expect formatted-fixed-date
          (with-mock (stub current-time => fixed-time)
                     (stub read-from-minibuffer => (number-to-string pomodoro-goal))
                     (start-day)
                     (gethash "date" current-day)))

  (desc "it creates a day with goal pomodoro-goal")
  (expect pomodoro-goal
          (with-mock (stub current-time => fixed-time)
                     (stub read-from-minibuffer => (number-to-string pomodoro-goal))
                     (start-day)
                     (gethash "goal" current-day)))

  (desc "it creates a day with no pomodoro")
  (expect '()
          (with-mock (stub current-time => fixed-time)
                     (stub read-from-minibuffer => (number-to-string pomodoro-goal))
                     (start-day)
                     (gethash "pomodori" current-day))))

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
                     (gethash "created_at" current-pomodoro)))

  (desc "it insert the new pomodoro in front of current-day's pomodoro list")
  (expect org-clock-current-task
          (with-mock (stub current-time => fixed-time)
                     (stub read-from-minibuffer => (number-to-string pomodoro-goal))
                     (start-day)
                     (start-pomodoro)
                     (gethash "title"
                              (nth 0 (gethash "pomodori" current-day))))))

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

;; save-day and load-day function
(expectations
  (desc "save-day saves current-day to json file")
  (expect formatted-fixed-date
          (with-mock (stub read-from-minibuffer => (number-to-string pomodoro-goal))
                     (start-day)
                     (save-day)
                     (let ((json-object-type 'hash-table))
                       (gethash "date"
                                (json-read-from-string
                                  (with-temp-buffer
                                    (insert-file-contents (save-file-path))
                                    (buffer-string)))))))

  (desc "load-day loads json file into current-day")
  (expect formatted-fixed-date
          (with-mock (stub read-from-minibuffer => (number-to-string pomodoro-goal))
                     (start-day)
                     (save-day)
                     (setq current-day nil)
                     (load-day)
                     (gethash "date" current-day))))
