(defun genki/summon-vim ()
  "Open current buffer file in vim"
  (interactive)
  (let ((file-name (buffer-file-name (current-buffer))))
    (if file-name
      (progn
        (kill-buffer (current-buffer))
        (call-process "gvim" nil nil nil file-name))
      (error "Current buffer doesn't point to a file yet."))
    (find-file file-name)))
