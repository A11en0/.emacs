(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar Allen/packages '(
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
		;; solarized-theme
		web-mode
		popwin
		) "Default packages")

(setq package-selected-packages Allen/packages)

(defun Allen/packages-installed-p ()
  (loop for pkg in Allen/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (Allen/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg Allen/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;;开启全局Company补全
(global-company-mode 1)

;;安装主题
(add-to-list 'Allen/packages 'monokai-theme)
(load-theme 'monokai 1)

;;强化删除空格
(require 'hungry-delete)
(global-hungry-delete-mode)

;;自动括号补全
(smartparens-global-mode t)

;;ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;;文件类型匹配
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
       auto-mode-alist))

;;开启popwin
(require 'popwin)
(popwin-mode 1)













(provide 'init-packages)
