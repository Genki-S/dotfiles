(require 'ert)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(require 'el-get)
(el-get 'sync '(el-mock ert-expectations request))
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
(setq complete-mood-choice "1")
(setq interrupt-reason "Gmail")

;; FIXME: this is dirty
(setq recodoro-save-dir "~/.org-recodoro-test")
(make-directory recodoro-save-dir t)

(defun with-my-fixtures (body &optional read-from-minibuffer-value)
  (unless read-from-minibuffer-value (setq read-from-minibuffer-value (number-to-string pomodoro-goal)))
  (unwind-protect
    (progn (setq current-day nil
                 current-pomodoro nil)
           (with-mock (stub current-time => fixed-time)
                      (stub read-from-minibuffer => read-from-minibuffer-value)
                      (funcall body)))))

;; start-day function
(defun with-my-start-day-fixtures (_body)
  (with-my-fixtures (lambda ()
                      (start-day)
                      (funcall _body))))

(expectations
  (desc "it creates a day with current date")
  (expect formatted-fixed-date
          (with-my-start-day-fixtures
            (lambda ()
              (gethash "date" current-day))))

  (desc "it creates a day with goal pomodoro-goal")
  (expect pomodoro-goal
          (with-my-start-day-fixtures
            (lambda ()
              (gethash "goal" current-day))))

  (desc "it creates a day with no pomodoro")
  (expect '()
          (with-my-start-day-fixtures
            (lambda ()
              (gethash "pomodori" current-day)))))

;; start-pomodoro function
(defun with-my-start-pomodoro-fixtures (_body)
  (with-my-fixtures (lambda ()
                      (start-day)
                      (start-pomodoro)
                      (funcall _body))))
(expectations
  (desc "it creates pomodoro with title set as org-clock-current-task")
  (expect org-clock-current-task
          (with-my-start-pomodoro-fixtures
            (lambda ()
              (gethash "title" current-pomodoro))))

  (desc "it creates pomodoro with created_at set as current-time")
  (expect formatted-fixed-time
          (with-my-start-pomodoro-fixtures
            (lambda ()
              (gethash "created_at" current-pomodoro))))

  (desc "it insert the new pomodoro in front of current-day's pomodoro list")
  (expect org-clock-current-task
          (with-my-start-pomodoro-fixtures
            (lambda ()
              (gethash "title"
                       (nth 0 (gethash "pomodori" current-day)))))))

;; complete-pomodoro function
(defun with-my-complete-pomodoro-fixtures (_body)
  (with-my-fixtures (lambda ()
                      (start-day)
                      (start-pomodoro)
                      (complete-pomodoro)
                      (funcall _body))
                    complete-mood-choice))

(expectations
  (desc "it sets completed_at as current-time")
  (expect formatted-fixed-time
          (with-my-complete-pomodoro-fixtures
            (lambda ()
              (gethash "completed_at" current-pomodoro))))

  (desc "it does not set interrupted_at")
  (expect nil
          (with-my-complete-pomodoro-fixtures
            (lambda ()
              (gethash "interrupted_at" current-pomodoro))))

  (desc "it creates reflection and set mood as good")
  (expect complete-mood
          (with-my-complete-pomodoro-fixtures
            (lambda ()
              (gethash "mood"
                       (gethash "reflection" current-pomodoro)))))

  (desc "it does not create interruption")
  (expect nil
          (with-my-complete-pomodoro-fixtures
            (lambda ()
              (gethash "interruption" current-pomodoro)))))

;; interrupt-pomodoro function
(defun with-my-interrupt-pomodoro-fixtures (_body)
  (with-my-fixtures (lambda ()
                      (start-day)
                      (start-pomodoro)
                      (interrupt-pomodoro)
                      (funcall _body))
                    interrupt-reason))

(expectations
  (desc "it sets interrupted_at as current-time")
  (expect formatted-fixed-time
          (with-my-interrupt-pomodoro-fixtures
            (lambda ()
              (gethash "interrupted_at" current-pomodoro))))

  (desc "it does not set completed_at")
  (expect nil
          (with-my-interrupt-pomodoro-fixtures
            (lambda ()
              (gethash "completed_at" current-pomodoro))))

  (desc "it creates interruption and set reason as interrupt-reason")
  (expect interrupt-reason
          (with-my-interrupt-pomodoro-fixtures
            (lambda ()
              (gethash "reason"
                       (gethash "interruption" current-pomodoro)))))

  (desc "it does not create reflection")
  (expect nil
          (with-my-interrupt-pomodoro-fixtures
            (lambda ()
              (gethash "reflection" current-pomodoro)))))

;; save-day and load-day function
(expectations
  (desc "save-day saves current-day to json file")
  (expect formatted-fixed-date
          (with-my-fixtures
            (lambda ()
              (start-day)
              (save-day)
              (let ((json-object-type 'hash-table))
                (gethash "date"
                         (json-read-from-string
                           (with-temp-buffer
                             (insert-file-contents (save-file-path))
                             (buffer-string))))))))

  (desc "load-day loads json file into current-day")
  (expect formatted-fixed-date
          (with-my-fixtures
            (lambda ()
              (start-day)
              (save-day)
              (setq current-day nil)
              (load-day)
              (gethash "date" current-day)))))
