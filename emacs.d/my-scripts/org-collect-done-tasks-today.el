(require 'org)

(defcustom org-collect-done-tasks-save-directory "~/.org-done-tasks"
  "A directory name in which done task files are saved"
  :type 'string)

(defun org-collect-done-tasks-file-name-function-default ()
  (format-time-string "%Y-%m-%d"))

(defun org-collect-done-tasks-file-full-path ()
  (concat org-collect-done-tasks-save-directory
	  "/"
	  (org-collect-done-tasks-file-name-function-default)
	  ".txt"))

(defun org-collect-done-tasks-prepare-save-file ()
  (unless (file-exists-p org-collect-done-tasks-save-directory)
    (make-directory org-collect-done-tasks-save-directory))
  (unless (file-accessible-directory-p org-collect-done-tasks-save-directory)
    (error "save directory not accessible"))
  (unless (file-exists-p (org-collect-done-tasks-file-full-path))
    (write-region "" nil (org-collect-done-tasks-file-full-path))))

(defun org-collect-done-tasks-collect ()
  "Actually collect the task"
  (org-collect-done-tasks-prepare-save-file)
  (save-excursion
    (org-back-to-heading)
    (append-to-file (concat (buffer-substring (line-beginning-position)
					      (line-end-position))
			    "\n")
		    nil
		    (org-collect-done-tasks-file-full-path))))

(defun org-collect-done-tasks-on-todo-state-change ()
  "Collect task if state has changed to one of done states"
  (when (member org-state org-done-keywords)
    (org-collect-done-tasks-collect)))
(add-hook 'org-after-todo-state-change-hook 'org-collect-done-tasks-on-todo-state-change)

(defun org-collect-done-tasks-open-today ()
  "Open today's done tasks file"
  (interactive)
  (find-file (org-collect-done-tasks-file-full-path)))
