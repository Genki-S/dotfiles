;; org-pomoboard.el: dashboard for org-pomodoro
(require 'org)
(require 'org-pomodoro)

;; TODO: Move these to general utility functions
(defun genki/days-to-time (days)
  (seconds-to-time (* 86400 days)))

(defun genki/tomorrow-time ()
  (time-add (current-time) (genki/days-to-time 1)))

;; Settings
(setq org-pomoboard-savedir "~/.org-pomoboard")
(setq org-pomoboard-template
      (expand-file-name "my-scripts/org-pomoboard-template.org" user-emacs-directory))

;; Utilities
(defun org-pomoboard/dashboard-filename (time)
  (concat (format-time-string "%Y-%m-%d" time) ".org"))

(defun org-pomoboard/dashboard-filename-full (time)
  (concat org-pomoboard-savedir "/" (org-pomoboard/dashboard-filename time)))

(defun org-pomoboard/property (property)
  "Return property name with prefix"
  (concat "PB_" property))

(defun org-pomoboard/set-property (property value)
  "Set org property with org-pomoboard prefix"
  (org-set-property (org-pomoboard/property property) value))

(defun org-pomoboard/add-to-multivalued-property (property value)
  "Add to multivalued org property with org-pomoboard prefix"
  (org-entry-add-to-multivalued-property (point) (org-pomoboard/property property) value))

(defun org-pomoboard/available-pomodoro (time)
  "Returns remaining pomodoro (Available - Planned)"
  (find-file (org-pomoboard/dashboard-filename-full time))
  (setq org-pomoboard-available-tomorrow (string-to-number (car (org-property-values (org-pomoboard/property "AVAILABLE")))))
  (goto-char (point-min))
  (search-forward "Tasks")
  (org-goto-first-child)
  (setq org-pomoboard-planned-tomorrow (string-to-number (org-entry-get (point) (org-pomoboard/property "ESTIMATE"))))
  (while (org-get-next-sibling)
         (setq org-pomoboard-planned-tomorrow (+ org-pomoboard-planned-tomorrow (string-to-number (org-entry-get (point) (org-pomoboard/property "ESTIMATE"))))))
  (- org-pomoboard-available-tomorrow org-pomoboard-planned-tomorrow))

(defun org-pomoboard/available-pomodoro-tomorrow ()
  (org-pomoboard/available-pomodoro (genki/tomorrow-time)))

;; Functions
(defun org-pomoboard/init-dashboard (time)
  "Prepare dashboard file"
  (make-directory org-pomoboard-savedir t)
  (let ((file (org-pomoboard/dashboard-filename-full time)))
    (copy-file org-pomoboard-template file)
    (find-file file)
    (goto-char (point-min))
    (next-line)
    (insert (org-pomoboard/dashboard-filename time))
    (search-forward "Stats")
    (org-pomoboard/set-property "AVAILABLE" (read-from-minibuffer "Available Pomodoro: "))))

(defun org-pomoboard/plan-tomorrow ()
  (interactive)
  (org-pomoboard/init-dashboard (genki/tomorrow-time))
  (message "Now go choose tasks to do tomorrow."))

(defun org-pomoboard/do-this-task-at (time)
  (org-store-link nil)
  (let ((file (org-pomoboard/dashboard-filename-full time))
        (estimation (read-from-minibuffer "Estimated Pomodoro: "))
        (deactivate-mark t))
    ; TODO: Make save-excursion work
    (save-excursion
      (find-file file)
      (goto-char (point-min))
      (search-forward "Tasks")
      (org-insert-todo-subheading nil)
      (insert (concat (plist-get org-store-link-plist :description) " ([[" (plist-get org-store-link-plist :link) "][origin]])"))
      (org-pomoboard/set-property "ESTIMATE" estimation))))

(defun org-pomoboard/do-this-task-tomorrow ()
  (interactive)
  (org-pomoboard/do-this-task-at (genki/tomorrow-time)))

(defun org-pomoboard/open-dashboard-today ()
  (interactive)
  (find-file (org-pomoboard/dashboard-filename-full (current-time))))

;; Tweak org-pomodoro
(defun org-pomoboard/input-productivity ()
  (org-pomoboard/add-to-multivalued-property "POMODORO" (read-from-minibuffer "How productive I had been? (max 10):")))

(defun org-pomoboard/reflect-pomodoro ()
  (call-process "activate-org")
  (org-clock-goto)
  ;; make it async not to pollute org-pomodoro procedure
  ;; (if I don't make it async, org-pomodoro's countdown speeds up after I finish read-from-minibuffer)
  (run-at-time "1 sec" nil 'org-pomoboard/input-productivity))
(add-hook 'org-pomodoro-finished-hook 'org-pomoboard/reflect-pomodoro)

(add-hook 'org-pomodoro-break-finished-hook (lambda () (call-process "activate-org")))
