;;自动加载外部修改过的文件
(global-auto-revert-mode 1)

;;禁止自动生成备份文件
(setq make-backup-files nil)

;;关闭自动保存文件
(setq auto-save-default nil)

;;显示行号
(global-linum-mode 1)

;;开启最近打开的文件功能
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;;添加钩子，用于括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;选中文本输入时直接替换
(delete-selection-mode t)

;;自动括号补全
(smartparens-global-mode t)

;;关闭警告音
(setq ring-bell-function 'ignore)

;;简化yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;;强化删除空格
(require 'hungry-delete)
(global-hungry-delete-mode)

;;开启popwin插件可以自动将光标移动到，新创建的窗口中
(require 'popwin)
(popwin-mode 1)

(provide 'init-better-defaults)
