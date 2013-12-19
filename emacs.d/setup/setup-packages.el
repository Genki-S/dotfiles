(require 'cl)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(setq url-http-attempt-keepalives nil)

(defvar custom-packages
  '(ac-slime
    ace-jump-mode
    ack-and-a-half
    auto-complete
    browse-kill-ring
    bash-completion
    clojure-mode
    coffee-mode
    dired-details
    expand-region
    elisp-slime-nav
    ess
    emacs-eclim
    find-file-in-project
    fill-column-indicator
    feature-mode
    flycheck
    frame-cmds
    frame-fns
    gist
    git-commit-mode
    gitconfig-mode
    gitignore-mode
    haml-mode
    haskell-mode
    helm
    helm-projectile
    htmlize
    key-chord
    inf-ruby
    ido-ubiquitous
    ido-vertical-mode
    ibuffer-vc
    less-css-mode
    lua-mode
    magit
    markdown-mode
    multiple-cursors
    markup
    melpa
    org
    org-plus-contrib
    org-pomodoro
    paredit
    popup
    puppet-mode
    rainbow-mode
    revive
    robe
    rinari
    ruby-block
    ruby-end
    ruby-tools
    rvm
    sass-mode
    scss-mode
    smooth-scrolling
    smex
    smart-forward
    shell-command
    volatile-highlights
    wgrep
    yaml-mode
    yasnippet
    zoom-frm)
  "A list of packages to ensure are installed at launch.")

;; (setq custom-packages '())

(defun custom-packages-installed-p ()
  (loop for p in custom-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (custom-packages-installed-p)
  (package-refresh-contents)
  (dolist (p custom-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'setup-packages)
