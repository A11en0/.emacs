;;latex相关
(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin/"))  
(setq exec-path (append exec-path '("/Library/TeX/texbin/")))
;;(load "auctex.el" nil t t)
;;(load "preview-latex.el" nil t t)
(add-hook 'LaTeX-mode-hook 
	(lambda()
	(add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
	(setq TeX-command-default "XeLaTeX")
	(setq TeX-save-querynil )
	(setq TeX-show-compilation t)))

;; 加载 company-auctex 并初始化
(use-package company-auctex
  :config
  (company-auctex-init))

;; 在 LaTeX 模式被启用时，启用 cdlatex
(use-package cdlatex
  :config
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
  (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex))

(provide 'init-latex)
