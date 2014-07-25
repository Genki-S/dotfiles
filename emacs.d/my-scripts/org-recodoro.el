(require 'org)
(require 'json)

;; * settings
(setq recodoro-save-dir "~/.org-recodoro")

;; * initialization
(make-directory recodoro-save-dir t)

;; * helper functions
(defun formatted-current-time ()
  (format-time-string "%Y-%m-%dT%T%z" (current-time)))

(defun formatted-current-date ()
  (format-time-string "%Y-%m-%d" (current-time)))

(defun save-file-path ()
  (concat recodoro-save-dir "/" (formatted-current-date) ".json"))

;; * models

;; day
;;  - date
;;  - goal
;;  --> * pomodoro
(defun make-day (goal)
  (let ((day (make-hash-table :test 'equal)))
    (puthash "date" (formatted-current-date) day)
    (puthash "goal" goal day)
    (puthash "pomodori" '() day)
    day))

;; pomodoro
;;  - title
;;  - created_at
;;  - finished_at
;;  - interrupted_at
;;  --> reflection
;;  --> interruption
(defun make-pomodoro (title)
  (let ((pomodoro (make-hash-table :test 'equal)))
    (puthash "title" title pomodoro)
    (puthash "created_at" (formatted-current-time) pomodoro)
    pomodoro))

;; reflection
;;  - mood
(defun make-reflection (mood)
  (let ((reflection (make-hash-table :test 'equal)))
    (puthash "mood" mood reflection)
    reflection))

;; interruption
;;  - reason
(defun make-interruption (reason)
  (let ((interruption (make-hash-table :test 'equal)))
    (puthash "reason" reason interruption)
    interruption))

;; * apis

(defun start-day ()
  (setq current-day (make-day (string-to-number (read-from-minibuffer "Your pomodoro goal: ")))))

(defun start-pomodoro ()
  (setq current-pomodoro (make-pomodoro org-clock-current-task))
  (puthash "pomodori" (cons current-pomodoro (gethash "pomodori" current-pomodoro)) current-day))

(defun complete-pomodoro ()
  (puthash "completed_at" (formatted-current-time) current-pomodoro)
  (let ((mood nil) (mood-index nil))
    (while (not (member mood-index '(1 2 3)))
           (setq mood-index (string-to-number (read-from-minibuffer "Mood (1: good, 2: so-so, 3: bad): "))))
    (setq mood (nth mood-index '(nil "good" "so-so" "bad")))
    (puthash "reflection" (make-reflection mood) current-pomodoro)))

(defun interrupt-pomodoro ()
  (puthash "interrupted_at" (formatted-current-time) current-pomodoro)
  (let ((reason (read-from-minibuffer "Reason of interruption: ")))
    (puthash "interruption" (make-interruption reason) current-pomodoro)))

;; * save and load
(defun save-day ()
  (with-temp-buffer
    (insert (json-encode current-day))
    (write-region (point-min) (point-max) (save-file-path))))
