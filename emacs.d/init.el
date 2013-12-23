;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

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

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Are we on a mac?
(setq is-mac (equal system-type 'darwin))

;; Install packages from MELPA
(require 'setup-packages)

;; Setup extensions
(require 'setup-ido)
(require 'setup-org)

;; Functions (load all files in defuns-dir)
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;; Setup global key-bindings
(require 'setup-global-bindings)
