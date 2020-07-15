;;简化窗口
(tool-bar-mode -1)
(menu-bar-mode -1)

;;主题
;;(add-to-list 'my/packages 'dracula-theme)
(load-theme 'dracula t)

;(add-to-list 'Allen/packages 'material-light)
;(load-theme 'material-light t)

;;关闭启动页面
(setq inhibit-splash-screen 1)

;;修改光标
(setq-default cursor-type 'bar)

;;全屏
;;(setq initial-frame-alist (quote((fullscreen . maximized))))
(setq default-frame-alist (quote((fullscreen . maximized))))

;;高亮当前行
(global-hl-line-mode t)

;;字体大小
(set-face-attribute 'default nil :height 175)
(provide 'init-ui)
