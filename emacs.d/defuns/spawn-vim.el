;; one pitfall is that you have to make vim generate swp file in buffer dir
(defun genki/spawn-vim ()
  "Edit current buffer with the decent editor in new tmux window"
  (interactive)
  (let ((file-name (buffer-file-name (current-buffer))))
    (if file-name
      (progn
        (let ((temp-file (make-temp-file "emacs_vim")))
          (write-region (point-min) (point-max) temp-file)
          (call-process "tmux" nil nil nil "new-window" (concat "vim " temp-file))
          (sleep-for 1)
          (let ((temp-file-basename (file-name-nondirectory temp-file)))
            (while (file-exists-p (replace-regexp-in-string temp-file-basename (concat "." temp-file-basename ".swp") temp-file))
                   (sleep-for 1))
            (insert-file-contents temp-file nil nil nil t))))
      (error "Current buffer doesn't point to a file yet."))))
