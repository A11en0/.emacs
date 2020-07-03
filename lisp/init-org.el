(require 'org)
(require 'org-pomodoro)
(setq org-src-fontify-natively t)

;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/.emacs.d/"))

;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "工作安排")
	 "* TODO [#B] %?\n  %i\n"
	 :empty-lines 1)))

;; r aka remeaber
(global-set-key (kbd "C-c r") 'org-capture)

;; org-elisp文学编程(可以直接在org文件中写配置)
(org-babel-load-file (expand-file-name "allen.org" user-emacs-directory))

(setq org-export-backends (quote (ascii html icalendar latex md)))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")

(provide 'init-org)
