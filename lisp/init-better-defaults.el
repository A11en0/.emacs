;;禁止自动生成备份文件
(setq make-backup-files nil)

(setq auto-save-default nil)

(global-linum-mode t)

;;开启最近打开的文件功能
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;;添加钩子，用于括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;选中文本输入时直接替换
(delete-selection-mode t)

(provide 'init-better-defaults)
