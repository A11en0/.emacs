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

(provide 'init-latex)
