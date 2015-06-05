;;; setup-mail.el --- Setup mu4e
;; This was an awesome resource : http://d.hatena.ne.jp/kenbeese/20121129/1354442823

(require 'mu4e)
(require 'mu4e-contrib)

;; default
;; (setq mu4e-maildir "~/Maildir")

(setq mu4e-drafts-folder "/Gmail/Drafts")
(setq mu4e-sent-folder   "/Gmail/Sent Mail")
(setq mu4e-trash-folder  "/Gmail/Bin")
(setq mu4e-attachment-dir  "~/Downloads") ;; attachments are saved here

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '(("/INBOX"               . ?i)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")
(setq mu4e-update-interval 300) ;; update every 5 minutes

;; something about ourselves
(setq
  user-mail-address "cfhoyuk.reccos.nelg@gmail.com"
  user-full-name "Genki Sugimoto"
  message-signature
  (concat
    "Genki Sugimoto\n"
    "Waseda University\n"
    "Washizaki Laboratory\n"
    "\n"
    "http://genkisugimoto.com"))
(setq mu4e-compose-signature message-signature)

;; sending mail
;; make sure the gnutls command line utils are installed
(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      '(("smtp.gmail.com" 587 "cfhoyuk.reccos.nelg@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

(defun open-with-browser-if-html ()
  (let ((html (mu4e-msg-field (mu4e-message-at-point t) :body-html))
        (tmpfile (format "%s/%d.html" temporary-file-directory (random))))
    (if html
      (progn
        (with-temp-file tmpfile
                        (insert
                          "<html>"
                          "<head><meta http-equiv=\"content-type\""
                          "content=\"text/html;charset=UTF-8\">"
                          html))
        (browse-url (concat "file://" tmpfile))))))
(add-hook 'mu4e-view-mode-hook 'open-with-browser-if-html)

;;; message view action
;; http://www.emacswiki.org/emacs/mu4e
(defun mu4e-msgv-action-view-in-browser (msg)
  "View the body of the message in a web browser."
  (interactive)
  (let ((html (mu4e-msg-field (mu4e-message-at-point t) :body-html))
        (tmpfile (format "%s/%d.html" temporary-file-directory (random))))
    (unless html (error "No html part for this message"))
    (with-temp-file tmpfile
                    (insert
                      "<html>"
                      "<head><meta http-equiv=\"content-type\""
                      "content=\"text/html;charset=UTF-8\">"
                      html))
    (browse-url (concat "file://" tmpfile))))

(add-to-list 'mu4e-view-actions
  '("View in browser" . mu4e-msgv-action-view-in-browser) t)

;; Show bcc field as well
(setq mu4e-view-fields
  '(:from :to :cc :bcc :subject :flags :date :maildir :mailing-list :tags :attachments :signature))

;; Show full address
(setq mu4e-view-show-addresses t)

;; For encrypting password
(require 'epa-file)
(epa-file-enable)
(setq auth-sources '("~/.authinfo.gpg" "~/.authinfo" "~/.netrc"))

(require 'netrc)
(defun offlineimap-get-password (host port)
  (let* ((netrc (netrc-parse (expand-file-name "~/.authinfo.gpg")))
         (hostentry (netrc-machine netrc host port port)))
    (when hostentry (netrc-get hostentry "password"))))

;; for multiple accounts
;; http://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html
(defvar my-mu4e-account-alist
  '(("Gmail"
     (mu4e-drafts-folder "/Gmail/Drafts")
     (mu4e-sent-folder "/Gmail/Sent Mail")
     (mu4e-trash-folder  "/Gmail/Bin")
     (user-mail-address "cfhoyuk.reccos.nelg@gmail.com"))
    ("Public"
     (mu4e-drafts-folder "/Public/Drafts")
     (mu4e-sent-folder "/Public/Sent Mail")
     (mu4e-trash-folder  "/Public/Bin")
     (user-mail-address "genki.sugimoto.jp@gmail.com"))
    ("Waseda"
     (mu4e-drafts-folder "/Waseda/Drafts")
     (mu4e-sent-folder "/Waseda/Sent Mail")
     (mu4e-trash-folder  "/Waseda/Bin")
     (user-mail-address "genki-sugimoto@asagi.waseda.jp"))))

(defun my-mu4e-insert-template ()
  "Set the template for composing a message."
  (let ((template-files (directory-files "~/org/templates/mail")))
    (setq templates (remove ".." (remove "." template-files)))
    (setq chosen-template (completing-read
                            (format "Template: (%s) "
                                    (mapconcat #'(lambda (var) var) templates "/"))
                            templates
                            nil t nil nil nil))
    (if chosen-template
      (insert-file-contents (concat "~/org/templates/mail/" chosen-template)))))
(add-hook 'message-mode-hook 'my-mu4e-insert-template)

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((msg mu4e-compose-parent-message)
         (account
           (if msg
             ; Set the From address based on the To address of the original.
             ; http://www.djcbsoftware.nl/code/mu/mu4e/Compose-hooks.html#Compose-hooks
             (cond
               ((mu4e-message-contact-field-matches msg :to "cfhoyuk.reccos.nelg@gmail.com")
                "Gmail")
               ((mu4e-message-contact-field-matches msg :to "genki.sugimoto.jp@gmail.com")
                "Public")
               ((mu4e-message-contact-field-matches msg :to "genki-sugimoto@asagi.waseda.jp")
                "Waseda")
               (t nil))
             nil)))
    (unless account
      (setq account
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var)) my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
    (let ((account-vars (cdr (assoc account my-mu4e-account-alist))))
      (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
        (error "No email account found")))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

; make it possible to attach file via helm-find-files
(eval-after-load "helm-files"
                 '(progn
                    ; See the definition of helm-find-files-1 function to know how to make source
                    (unless helm-source-find-files
                      (setq helm-source-find-files (helm-make-source
                                                     "Find Files" 'helm-source-ffiles)))
                    (helm-add-action-to-source "Attach file"
                                               'helm-ff-gnus-attach-files
                                               helm-source-find-files)))

(provide 'setup-mail)
;;; setup-mail.el ends here
