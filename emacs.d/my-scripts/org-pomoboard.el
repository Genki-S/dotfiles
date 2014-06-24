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
(setq org-pomoboard-statistics-csv-file "stat.csv")

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

(defun org-pomoboard/get-property (property)
  "Get org property with org-pomoboard prefix"
  (org-entry-get (point) (org-pomoboard/property property)))

(defun org-pomoboard/set-stat (property value)
  (save-excursion
    (goto-char (point-min))
    (search-forward "Stats")
    (org-pomoboard/set-property property value)))

(defun org-pomoboard/get-stat (property)
  (save-excursion
    (goto-char (point-min))
    (search-forward "Stats")
    (org-pomoboard/get-property property)))

(defun org-pomoboard/add-to-multivalued-property (property value)
  "Add to multivalued org property with org-pomoboard prefix"
  (org-set-property (org-pomoboard/property property)
                    (mapconcat 'identity
                               (nreverse (cons value
                                               (nreverse (org-entry-get-multivalued-property
                                                           (point)
                                                           (org-pomoboard/property property)))))
                               " ")))

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

(defun org-pomoboard/done-pomodoro ()
  "Returns done pomodoro count"
  (save-excursion
    (goto-char (point-min))
    (search-forward "Tasks")
    (org-goto-first-child)
    (setq org-pomoboard-done (length (org-entry-get-multivalued-property (point) (org-pomoboard/property "POMODORO"))))
    (while (org-get-next-sibling)
           (setq org-pomoboard-done (+ org-pomoboard-done (length (org-entry-get-multivalued-property (point) (org-pomoboard/property "POMODORO")))))))
  org-pomoboard-done)

(defun org-pomoboard/planned-pomodoro ()
  "Returns planned pomodoro count"
  (save-excursion
    (goto-char (point-min))
    (search-forward "Tasks")
    (org-goto-first-child)
    (setq org-pomoboard-planned (string-to-number (org-entry-get (point) (org-pomoboard/property "ESTIMATE"))))
    (while (org-get-next-sibling)
           (setq org-pomoboard-planned (+ org-pomoboard-planned (string-to-number (org-entry-get (point) (org-pomoboard/property "ESTIMATE")))))))
  org-pomoboard-planned)

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
    (insert (org-pomoboard/dashboard-filename time))
    (org-pomoboard/set-stat "DONE" "0")
    (org-pomoboard/set-stat "SCORE" "0")
    (org-pomoboard/set-stat "AVAILABLE" (read-from-minibuffer "Available Pomodoro: "))))

(defun org-pomoboard/plan-day (time)
  (org-pomoboard/init-dashboard time)
  (message "Now go choose tasks to do tomorrow."))

(defun org-pomoboard/plan-today ()
  (interactive)
  (org-pomoboard/plan-day (current-time)))

(defun org-pomoboard/plan-tomorrow ()
  (interactive)
  (org-pomoboard/plan-day (genki/tomorrow-time)))

(defun org-pomoboard/do-this-task-at (time)
  (org-store-link nil)
  (let ((file (org-pomoboard/dashboard-filename-full time))
        (estimation (read-from-minibuffer "Estimated Pomodoro: "))
        (deactivate-mark t))
    ; TODO: Make save-excursion work
    (save-excursion
      (find-file file)
      (goto-char (point-max))
      (evil-open-below 1)
      (insert (concat "** TODO " (plist-get org-store-link-plist :description) " ([[" (plist-get org-store-link-plist :link) "][origin]])"))
      (evil-normal-state)
      (org-pomoboard/set-property "ESTIMATE" estimation)
      (org-pomoboard/update-stats-planned)
      (message (concat (number-to-string (org-pomoboard/available-pomodoro time)) " MORE AVAILABLE")))))

(defun org-pomoboard/do-this-task-today ()
  (interactive)
  (org-pomoboard/do-this-task-at (current-time)))

(defun org-pomoboard/do-this-task-tomorrow ()
  (interactive)
  (org-pomoboard/do-this-task-at (genki/tomorrow-time)))

(defun org-pomoboard/open-dashboard-today ()
  (interactive)
  (find-file (org-pomoboard/dashboard-filename-full (current-time))))

(defun org-pomoboard/update-stats-planned ()
  (goto-char (point-min))
  (org-pomoboard/set-stat "PLANNED" (number-to-string (org-pomoboard/planned-pomodoro))))

(defun org-pomoboard/update-stats-done ()
  (goto-char (point-min))
  (org-pomoboard/set-stat "DONE" (number-to-string (org-pomoboard/done-pomodoro))))

;; About Score
;; - Max score is 100
;; - 1 pomodoro has potential score of $ 100 / #planned $
;; - the score of 1 pomodoro is calculated by $ potential * (productivity / 10) $ where 10 is the max value of productivity
(defun org-pomoboard/score ()
  (let (planned (org-pomoboard/planned-pomodoro))
    (save-excursion
      (goto-char (point-min))
      (search-forward "Tasks")
      (org-goto-first-child)
      (setq org-pomoboard-productivity-sum (apply '+ (mapcar 'string-to-number (org-entry-get-multivalued-property (point) (org-pomoboard/property "POMODORO")))))
      (while (org-get-next-sibling)
             (setq org-pomoboard-productivity-sum (+ org-pomoboard-productivity-sum (apply '+ (mapcar 'string-to-number (org-entry-get-multivalued-property (point) (org-pomoboard/property "POMODORO")))))))
      (setq org-pomoboard-potential (/ (float 100) (org-pomoboard/planned-pomodoro)))
      (setq org-pomoboard-score (* org-pomoboard-potential (/ (float org-pomoboard-productivity-sum) 10))))
    org-pomoboard-score))

(defun org-pomoboard/update-stats-score ()
  (goto-char (point-min))
  (org-pomoboard/set-stat "SCORE" (number-to-string (org-pomoboard/score))))

;; Tweak org-pomodoro
(defun org-pomoboard/input-productivity ()
  (org-clock-goto)
  (org-pomoboard/add-to-multivalued-property "POMODORO" (read-from-minibuffer "How productive I had been? (max 10):"))
  (org-pomoboard/update-stats-done)
  (org-pomoboard/update-stats-score)
  (message (concat "Now your score is " (org-pomoboard/get-stat "SCORE"))))

(defun org-pomoboard/reflect-pomodoro ()
  (call-process "activate-org")
  ;; make it async not to pollute org-pomodoro procedure
  ;; (if I don't make it async, org-pomodoro's countdown speeds up after I finish read-from-minibuffer)
  (run-at-time "1 sec" nil 'org-pomoboard/input-productivity))
(add-hook 'org-pomodoro-finished-hook 'org-pomoboard/reflect-pomodoro)

(add-hook 'org-pomodoro-break-finished-hook (lambda () (call-process "activate-org")))

;; Publish
(defun org-pomoboard/build-statistic-csv ()
  "Returns statistic csv of current pomoboard buffer (assuming it's today's board)

Values are: date, available, planned, done, score"
  (let (statistic-list '())
    (setq statistic-list (cons (format-time-string "%Y-%m-%d" (current-time)) statistic-list))
    (dolist (property '("AVAILABLE" "PLANNED" "DONE" "SCORE"))
      (setq statistic-list (cons (org-pomoboard/get-stat property) statistic-list)))
    (mapconcat 'identity (nreverse statistic-list) ",")))

(defun org-pomoboard/save-statistics ()
  "Save statistic to a file org-pomoboard-statistics-csv-file (assume it's never called twice)"
  (let ((file (concat org-pomoboard-savedir "/" org-pomoboard-statistics-csv-file))
        (csv-string (concat (org-pomoboard/build-statistic-csv) "\n")))
    (append-to-file csv-string nil file)))

(defun org-pomoboard/finish-today ()
  (interactive)
  (unless (org-pomoboard/get-stat "FINISHED")
    (org-pomoboard/save-statistics)
    (org-pomoboard/set-stat "FINISHED" "t")
    (message "WELL DONE!")))
