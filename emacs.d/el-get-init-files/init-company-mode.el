(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'company-mode-hook
          (lambda ()
            (add-to-list 'company-backends '(company-yasnippet company-ispell))))
