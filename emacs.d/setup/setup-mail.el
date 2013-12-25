;;; setup-mail.el --- Setup mu4e

(require 'mu4e)

;; default
;; (setq mu4e-maildir "~/Maildir")

(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Bin")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '(("/INBOX"               . ?i)
        ("/[Gmail].Sent Mail"   . ?s)
        ("/[Gmail].Trash"       . ?t)
        ("/[Gmail].All Mail"    . ?a)))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; something about ourselves
(setq
  user-mail-address "cfhoyuk.reccos.nelg@gmail.com"
  user-full-name  "Genki Sugimoto"
  message-signature
  (concat
    "--------------\n"
    "Genki Sugimoto\n"))

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

(provide 'setup-mail)
;;; setup-mail.el ends here
