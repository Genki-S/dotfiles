(require 'org)
(require 'org-pomodoro)
(require 'json)

(defconst org-recodoro "0.0.1"
  "The version of the org-recodoro lisp code.")

(defgroup org-recodoro nil
  "Record your pomodoro through API and see your achievements."
  :prefix "org-recodoro-"
  :group 'tools)

(defcustom org-recodoro-api-server "http://infinite-mountain-2191.herokuapp.com/api/v1/pomodori"
  "Recodoro Api server."
  :type '(string)
  :group 'org-recodoro)

(defcustom org-recodoro-uid ""
  "Recodoro User id."
  :type '(string)
  :group 'org-recodoro)

(defcustom org-recodoro-save-dir "~/.org-recodoro"
  "Save response distination."
  :type '(directory)
  :group 'org-recodoro)


;; * initialization
(make-directory org-recodoro-save-dir t)

;; * helper functions
(defun formatted-current-time ()
  (format-time-string "%Y-%m-%dT%T%z" (current-time)))

(defun formatted-current-date ()
  (format-time-string "%Y-%m-%d" (current-time)))

(defun save-file-path ()
  (concat org-recodoro-save-dir "/" (formatted-current-date) ".json"))

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
;;  - started_at
;;  - finished_at
;;  - interrupted_at
;;  --> reflection
;;  --> interruption
(defun make-pomodoro (title)
  (let ((pomodoro (make-hash-table :test 'equal)))
    (puthash "title" title pomodoro)
    (puthash "started_at" (formatted-current-time) pomodoro)
    pomodoro))

;; reflection
;;  - evaluation
(defun make-reflection (evaluation)
  (let ((reflection (make-hash-table :test 'equal)))
    (puthash "evaluation" evaluation reflection)
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
  (setq current-pomodoro (make-pomodoro org-clock-current-task)))
  ;; currently don't care about day model
  ; (puthash "pomodori" (cons current-pomodoro (gethash "pomodori" current-pomodoro)) current-day))

(defun finish-pomodoro ()
  (puthash "finished_at" (formatted-current-time) current-pomodoro)
  (let ((evaluation nil) (evaluation-index nil))
    (while (not (member evaluation-index '(1 2 3)))
           (setq evaluation-index (string-to-number (read-from-minibuffer "Evaluation (1: good, 2: so-so, 3: bad): "))))
    (setq evaluation (nth evaluation-index '(nil "-1" "0" "1")))
    (puthash "reflection" (make-reflection evaluation) current-pomodoro)))

(defun interrupt-pomodoro ()
  (puthash "interrupted_at" (formatted-current-time) current-pomodoro)
  (let ((reason (read-from-minibuffer "Reason of interruption: ")))
    (puthash "interruption" (make-interruption reason) current-pomodoro)))

;; * save and load
(defun save-day ()
  (with-temp-buffer
    (insert (json-encode current-day))
    (write-region (point-min) (point-max) (save-file-path))))

(defun load-day ()
  (let ((json-object-type 'hash-table))
    (setq current-day (json-read-from-string
                        (with-temp-buffer
                          (insert-file-contents (save-file-path))
                          (buffer-string))))))

;; * POST method
(defun post-pomodoro ()
  (call-process "curl"
                nil 0 nil
                "-HAccept:application/json"
                "-HContent-type:application/json"
                "-XPOST"
                "-d" (json-encode-hash-table current-pomodoro)
                "http://localhost:3000/api/v1/pomodori"))

;; * Hook onto org-pomodoro
(add-hook 'org-pomodoro-started-hook 'start-pomodoro)

(add-hook 'org-pomodoro-finished-hook
          (lambda ()
            ;; make it async not to pollute org-pomodoro procedure
            ;; (if I don't make it async, org-pomodoro's countdown speeds up after I finish read-from-minibuffer)
            (run-at-time "1 sec" nil (lambda ()
                                       (call-process "activate-org")
                                       (finish-pomodoro)
                                       (post-pomodoro)))))

(add-hook 'org-pomodoro-killed-hook
          (lambda ()
            (run-at-time "1 sec" nil (lambda ()
                                       (call-process "activate-org")
                                       (interrupt-pomodoro)
                                       (post-pomodoro)))))

(add-hook 'org-pomodoro-break-finished-hook (lambda () (call-process "activate-org")))
