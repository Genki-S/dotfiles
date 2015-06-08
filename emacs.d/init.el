(setq debug-on-error t)

;; create custom.el if it does not exist
(defconst custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

;; start as a server if there is no server
(load "server")
(unless (server-running-p) (server-start))

;; Set the dir variables used by these init scripts
(setq themes-dir (expand-file-name "themes" user-emacs-directory))
(add-to-list 'load-path themes-dir)
(setq vendor-dir (expand-file-name "vendor" user-emacs-directory))
(add-to-list 'load-path vendor-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(add-to-list 'load-path defuns-dir)
(setq defadvices-dir (expand-file-name "defadvices" user-emacs-directory))
(add-to-list 'load-path defadvices-dir)
(setq backups-dir (expand-file-name "backups" user-emacs-directory))
(add-to-list 'load-path backups-dir)
(setq setup-dir (expand-file-name "setup" user-emacs-directory))
(add-to-list 'load-path setup-dir)
(setq snippets-dir (expand-file-name "snippets" user-emacs-directory))
(add-to-list 'load-path snippets-dir)
(setq tmp-dir (expand-file-name "tmp" user-emacs-directory))
(add-to-list 'load-path tmp-dir)

;; http://www.emacswiki.org/emacs/ElispCookbook#toc4
(defun string/starts-with (s begins)
  "Return non-nil if string S starts with BEGINS."
  (cond ((>= (length s) (length begins))
         (string-equal (substring s 0 (length begins)) begins))
        (t nil)))

(defun string/ends-with (s ending)
  "Return non-nil if string S ends with ENDING."
  (cond ((>= (length s) (length ending))
         (let ((elength (length ending)))
           (string= (substring s (- 0 elength)) ending)))
        (t nil)))

;; Functions (load all files in defuns-dir)
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (and (file-regular-p file) (string/ends-with file ".el"))
    (load file)))

;; Advices
(dolist (file (directory-files defadvices-dir t "\\w+"))
  (when (and (file-regular-p file) (string/ends-with file ".el"))
    (load file)))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; ensure el-get is installed
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously
      "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; add my recipes
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
;; init files for packages
(setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")

;; packages to install from el-get
;; http://shibayu36.hatenablog.com/entry/2013/04/30/175740
(defvar genki/el-get-packages
  '(
    evil
    evil-leader
    evil-surround
    evil-tabs
    org-mode
    flycheck
    xml-rpc-el
    metaweblog
    org2blog
    org-pomodoro
    wc-mode
    mu4e
    color-theme-solarized
    helm
    yasnippet
    company-mode
    el-mock
    ert-expectations
    )
  "A list of packages to install from el-get at launch.")

;; install new packages and init already installed packages
(el-get 'sync genki/el-get-packages)

;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

;; Setup extensions
(if (getenv "ORGMODE")
  (require 'setup-org))
(require 'setup-mail)

;; Setup global key-bindings
(require 'setup-global-bindings)

;; enable spell checker
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; color
;; https://github.com/sellout/emacs-color-theme-solarized
(load-theme 'solarized t)
(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)

;; my scripts
(setq my-scripts-dir (expand-file-name "my-scripts" user-emacs-directory))
(dolist (file (directory-files my-scripts-dir t "\\w+"))
  (when (and (file-regular-p file) (string/ends-with file ".el"))
    (load file)))

;; GUI
;; timer is needed, see: http://www.emacswiki.org/emacs/FullScreen#toc3
; disabling because I don't use GUI for now
; (run-with-idle-timer 0.1 nil 'maximize-frame)
