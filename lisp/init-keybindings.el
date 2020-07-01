;;ivy
(setq enable-recursive-minibuffers t)

(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)

(global-set-key (kbd "<f2>") 'open-init-file
)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; finding file in current git repo 
(global-set-key (kbd "C-c p") 'counsel-git)

(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)

(global-set-key "\M-p"  'bs-cycle-previou)
(global-set-key "\M-n"  'bs-cycle-next)

(provide 'init-keybindings)
