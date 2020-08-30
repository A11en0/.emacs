;;ivy
(setq enable-recursive-minibuffers t)

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)

(global-set-key (kbd "<f2>") 'open-init-file)

(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; finding file in current git repo 
(global-set-key (kbd "C-c p") 'counsel-git)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(global-set-key (kbd "s-/") 'hippie-expand)

;; 延迟加载 将dired模式下Enter键绑定为"选择文件"
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)) 

;; (global-set-key "\M-p"  'bs-cycle-previou)
;; (global-set-key "\M-n"  'bs-cycle-next)

(global-set-key (kbd "M-p") 'previous-buffer)
(global-set-key (kbd "M-n") 'next-buffer)

(global-set-key "\M-;" 'comment-or-uncomment-region-or-line)

;; 同时编辑多个区域
(global-set-key (kbd "C-;") 'iedit-mode)

;; 定位代码中的函数
(global-set-key (kbd "M-s i") 'counsel-imenu)

;; fzf工具
(global-set-key (kbd "M-s f") 'fzf)

(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "M-s o") 'occur-dwim)

;; company补全使用Ctrl键上下选择
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)

  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous))

(global-set-key (kbd "M-s s") 'helm-do-ag-project-root)

(global-set-key (kbd "C-c w") #'aya-create)
(global-set-key (kbd "C-c y") #'aya-expand)

;; org-capture 用来快速地记下心中一闪而过的某个想法
(global-set-key (kbd "C-c c") 'org-capture)

;; meghanada-exec-main
(with-eval-after-load 'meghanada
  (define-key meghanada-mode-map (kbd "C-c r") 'meghanada-exec-main))

;; (global-set-key (kbd "C-w") 'backward-kill-word)
(provide 'init-keybindings)



