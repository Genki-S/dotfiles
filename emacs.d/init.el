;; Set the dir variables used by these init scripts
(setq themes-dir (expand-file-name "themes" user-emacs-directory))
(add-to-list 'load-path themes-dir)
(setq vendor-dir (expand-file-name "vendor" user-emacs-directory))
(add-to-list 'load-path vendor-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(add-to-list 'load-path defuns-dir)
(setq backups-dir (expand-file-name "backups" user-emacs-directory))
(add-to-list 'load-path backups-dir)
(setq setup-dir (expand-file-name "setup" user-emacs-directory))
(add-to-list 'load-path setup-dir)
(setq snippets-dir (expand-file-name "snippets" user-emacs-directory))
(add-to-list 'load-path snippets-dir)
(setq tmp-dir (expand-file-name "tmp" user-emacs-directory))
(add-to-list 'load-path tmp-dir)

;; Functions (load all files in defuns-dir)
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;; Install packages from MELPA
(require 'setup-packages)

;; TODO: migrate to el-get from package, or use both?
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
    xml-rpc
    metaweblog
    org2blog
    wc-mode
    mu4e
    color-theme-solarized
    )
  "A list of packages to install from el-get at launch.")

;; install new packages and init already installed packages
(el-get 'sync genki/el-get-packages)

;; require all packages (my first elisp code. why is it working?)
(loop for p in genki/el-get-packages
 do (require p))

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
(require 'setup-ido)
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
(load-theme 'solarized-dark t)

;; various
(defun genki/remind-workout ()
  (osx-notification "Get Active!" "Do some workout now."))
(run-at-time "00:00" 3600 'genki/remind-workout)

(defun genki/remind-breath ()
  (osx-notification "Breath Properly" ""))
(run-at-time "00:30" 3600 'genki/remind-workout)

(setq genki-org-current-task "NOT CLOCKING IN...")
(defun genki/remind-current-task ()
  (osx-notification "Current Task" genki-org-current-task))
(run-at-time "00:00" 1800 'genki/remind-current-task)
