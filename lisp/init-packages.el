(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			   ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar my/packages '(
			 ;; --- Auto-completion ---
			 company
			 ;; --- Better Editor ---
			 hungry-delete
			 counsel
			 smartparens
			 ;; --- Major Mode ---
			 js2-mode
			 ;; --- Minor Mode ---
			 nodejs-repl
			 exec-path-from-shell
			 ;; --- Themes ---
			 monokai-theme
			 zenburn-theme
			 dracula-theme
			 ;; solarized-theme
			 web-mode
			 popwin
			 elpy
			 flycheck ;; add the flycheck package
			 py-autopep8
			 ein
			 ;;LaTeX
			 auctex
			 yasnippet
			 yasnippet-snippets
			 anaconda-mode
			 expand-region
			 ) "Default packages")

(setq package-selected-packages my/packages)

(defun my/packages-installed-p ()
  (loop for pkg in my/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;;ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;;开启全局Company补全
(global-company-mode 1)

;;文件类型匹配
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
       auto-mode-alist))

(require 'elpy nil t)
(elpy-enable)
(setq python-shell-interpreter "python3")

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; 选中功能增强
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; (setq hippie-expand-try-function-list '(try-expand-debbrev
;;                                         try-expand-debbrev-all-buffers
;;                                         try-expand-debbrev-from-kill
;;                                         try-complete-file-name-partially
;;                                         try-complete-file-name
;;                                         try-expand-all-abbrevs
;;                                         try-expand-list
;;                                         try-expand-line
;;                                         try-complete-lisp-symbol-partially
;;                                         try-complete-lisp-symbol))

;; (global-set-key (kbd "s-/") 'hippie-expand)

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'company-bbdb) '(company-anaconda))))

;;yasnippet TAB自动补全插件
(add-to-list 'load-path "~/.emacs.d/snippets")
(require 'yasnippet)
(require 'yasnippet-snippets)
(yas-global-mode 1)			

(provide 'init-packages)

