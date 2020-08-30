;;自动加载外部修改过的文件
(global-auto-revert-mode 1)

;; 关闭滚动条
(scroll-bar-mode 0)

;; (setq default-tab-width 4)
;; (setq indent-tabs-mode nil)

;;禁止自动生成备份文件
(setq make-backup-files nil)

;;关闭自动保存文件
;;(setq auto-save-default nil)

;;显示行号
(global-linum-mode 1)

;;开启最近打开的文件功能
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;;添加钩子，用于括号匹配
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;选中文本输入时直接替换
(delete-selection-mode t)

(set-language-environment "UTF-8")

;;自动括号补全
(smartparens-global-mode t)
(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)

(sp-local-pair 'emacs-lisp-mode "`" nil :actions nil)

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

;; dired常用操作
;; + 创建目录
;; g 刷新目录
;; C 拷贝
;; D 删除
;; R 重命名
;; d 标记删除
;; u 取消标记
;; x 执行所有的标记

;; dired每次复制目录时递归复制

(setq dired-recursive-copies 'always)

;; dired每次删除目录时递归删除(危险/暂不启用)
;;(setq dired-recursive-deletes 'always)

(put 'dired-find-alternate-file 'disabled nil)

;; 主动加载 Dired Mode
(require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)

(require 'dired-x)

(setq dired-dwin-target t)

(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; Shifu
					    ("8zl" "zilongshanren")
					    ;; Tudi
					    ("8lxy" "lixinyang")
					    ))
;; 块代码缩进
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion 
    (if (region-active-p)
        (progn
          (indent-region (region-beginning) (region-end))
          (message "Indent selected region."))
      (progn
        (indent-buffer)
        (message "Indent buffer.")))))

;; hippie 补全配置
(setq hippie-expand-try-function-list '(try-expand-debbrev
                                        try-expand-debbrev-all-buffers
                                        try-expand-debbrev-from-kill
                                        try-complete-file-name-partially
                                        try-complete-file-name
                                        try-expand-all-abbrevs
                                        try-expand-list
                                        try-expand-line
                                        try-complete-lisp-symbol-partially
                                        try-complete-lisp-symbol))


;;解决在不同系统中的换行符，例如在 DOS 系统下的 \r(^M) 换行符， 这让我们有时候在 Unix 系统中很是头疼，因为它的存在会使版本控制误以为整行的代码都 被修改过而造成不必要的麻烦。
;;下面是隐藏的方法
(defun hidden-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (unless buffer-display-table
    (setq buffer-display-table (make-display-table)))
  (aset buffer-display-table ?\^M []))

;;使用下面的代码则可以定义函数将此换行符删除
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; 注释当前光标所在行
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))

;; python运行当前文件
(defun python/run-current-file (&optional directory)
  "Execute the current python file."
  (interactive
   (list (or (and current-prefix-arg
                  (read-directory-name "Run in directory: " nil nil t))
             default-directory)))
  (when (buffer-file-name)
    (let* ((command (or (and (boundp 'executable-command) executable-command)
                        (concat "python3 " (buffer-file-name))))
           (default-directory directory)
           (compilation-ask-about-save nil))
      (executable-interpret (read-shell-command "Run: " command)))))

(define-key python-mode-map [f5] 'python/run-current-file)

;; js2 flycheck
(add-hook 'js2-mode-hook 'flycheck-mode)

(provide 'init-better-defaults)
