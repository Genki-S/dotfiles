;; http://www.ooblick.com/weblog/2010/06/03/monthly-reports-with-org-mode/

(defun genki/daily-report ()
  "Show a list of tasks closed today."
  (interactive)
  (require 'org-agenda)
  ;; add *.org_archive files to agenda-files
  (let* ((org-agenda-archives-mode t)
         (org-agenda-entry-types '(:closed)))
    (org-agenda-list nil
                     (format-time-string "%Y-%m-%d")
                     1)))
