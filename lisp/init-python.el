(defun my-python-mode-config ()
  (setq python-indent-offset 4
        python-indent 4
        indent-tabs-mode nil
        default-tab-width 4

        ;; 设置 run-python 的参数
        python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i"
        python-shell-prompt-regexp "In \\[[0-9]+\\]: "
        python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
        python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
        python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
        python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

  (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
  (hs-minor-mode t)                     ;开启 hs-minor-mode 以支持代码折叠
  (auto-fill-mode 0)                    ;关闭 auto-fill-mode，拒绝自动折行
  (whitespace-mode t)                   ;开启 whitespace-mode 对制表符和行为空格高亮
  (hl-line-mode t)                      ;开启 hl-line-mode 对当前行进行高亮
  (pretty-symbols-mode t)               ;开启 pretty-symbols-mode 将 lambda 显示成希腊字符 λ
  (set (make-local-variable 'electric-indent-mode) nil)) ;关闭自动缩进

(add-hook 'python-mode-hook 'my-python-mode-config)

(setq jedi:environment-root "jedi")
(setq jedi:server-command `("~/.emacs.d/.python-environments/jedi/bin/jediepcserver"))

(defun config/enable-jedi ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'jedi:setup)
(add-hook 'python-mode-hook 'config/enable-jedi)

;; 输入句点符号 "." 的时候自动弹出补全列表，这个主要是方便用来选择 Python package 的子模块或者方法
(setq jedi:complete-on-dot t)

;; 补全时能识别简写，这个是说如果我写了 "import tensorflow as tf" ，那么我再输入 "tf." 的时候能自动补全
(setq jedi:use-shortcuts t)

;; 设置补全时需要的最小字数(默认就是 3)
;; (setq compandy-minimum-prefix-length 1)

;; 设置弹出的补全列表的外观
;; 让补全列表里的各项左右对齐
(setq company-tooltip-align-annotations t)

;补全列表里的项按照使用的频次排序，这样经常使用到的会放在前面，减少按键次数
(setq company-transformers '(company-sort-by-occurrence))

;在弹出的补全列表里移动时可以前后循环，默认如果移动到了最后一个是没有办法再往下移动的
(setq company-selection-wrap-around t)

;; Python anaconda 配置
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'company-bbdb) '(company-anaconda))))

(provide 'init-python)



