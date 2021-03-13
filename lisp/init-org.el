(require 'org)
(require 'org-pomodoro)
(setq org-src-fontify-natively t)

;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/.emacs.d/"))

;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)

;; org-agenda 自定义配置
(setq org-agenda-custom-commands
      '(
        ("w" . "任务安排")
        ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
        ("wb" "重要且不紧急的任务" tags-todo "-weekly-monthly-daily+PRIORITY=\"B\"")
        ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
        ("W" "Weekly Review"
         ((stuck "") ;; review stuck projects as designated by org-stuck-projects
          (tags-todo "project")
          (tags-todo "daily")
          (tags-todo "weekly")
          (tags-todo "school")
          (tags-todo "code")
          (tags-todo "theory")
          ))
        ))

(setq org-todo-keywords
      '((sequence "BUG(b!)" "|" "FIXED(f!)")
	(sequence "TODO(t!)" "SOMEDAY(s)" "|" "DONE(d!)" "CANCELED(c @/!)")
	))

;; (setq org-capture-templates
;;       '(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "工作安排")
;; 	 "* TODO [#B] %?\n  %i\n"
;; 	 :empty-lines 1))) 

;; 这边就是为路径赋值
(defvar org-agenda-dir "" "gtd org files location")
(setq-default org-agenda-dir "~/gtd/")
(setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
(setq org-agenda-file-task (expand-file-name "task.org" org-agenda-dir))
(setq org-agenda-file-calendar (expand-file-name "calendar.org" org-agenda-dir))
(setq org-agenda-file-finished (expand-file-name "finished.org" org-agenda-dir))
(setq org-agenda-file-canceled (expand-file-name "canceled.org" org-agenda-dir))

;; 添加每次打开时可添加的任务类型
(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline org-agenda-file-task "Work")
         "* TODO [#B] %?\n  %i\n"
         :empty-lines 1)
        ("l" "Tolearn" entry (file+headline org-agenda-file-task "Learning")
         "* TODO [#B] %?\n  %i\n"
         :empty-lines 1)
        ("h" "Toplay" entry (file+headline org-agenda-file-task "Hobbies")
         "* TODO [#C] %?\n  %i\n"
         :empty-lines 1)
        ("o" "Todo_others" entry (file+headline org-agenda-file-task "Others")
         "* TODO [#C] %?\n  %i\n"
         :empty-lines 1)
        ("n" "notes" entry (file+headline org-agenda-file-note "Quick notes")
         "* %?\n  %i\n %U"
         :empty-lines 1)
        ("i" "ideas" entry (file+headline org-agenda-file-note "Quick ideas")
         "* %?\n  %i\n %U"
         :empty-lines 1)
        )
      )

;; (setq org-capture-templates
;;       `(("t" "task" entry (file "~/Personal/gtd/inbox.org")
;;          "* TODO %?\nCaptured %<%Y-%m-%d %H:%M>") 
;;         ("n" "note" entry (file "~/Personal/gtd/notes.org")
;;          "* Note %<%Y-%m-%d %H:%M>\n%?")))

;; org-elisp文学编程(可以直接在org文件中写配置) ::不常用
;;(org-babel-load-file (expand-file-name "allen.org" user-emacs-directory))

(setq org-export-backends (quote (ascii html icalendar latex md)))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome-stable")

(require 'org-ref)

(setq reftex-default-bibliography '("~/org/ref/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/org/ref/notes.org"
      org-ref-default-bibliography '("~/org/ref/references.bib")
      org-ref-pdf-directory "~/org/ref/pdfs/")

(setq bibtex-completion-bibliography "~/org/ref/references.bib"
      bibtex-completion-library-path "~/org/ref/pdfs"
      bibtex-completion-notes-path "~/org/ref/notes.org")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
      (lambda (fpath)
	(start-process "open" "*open*" "open" fpath)))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)

;;  org-mode 8.0
;; (setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
;; "xelatex -interaction nonstopmode %f"))
;; (setq org-latex-pdf-process (list "latexmk -shell-escape %f"))
(setq org-latex-pdf-process (list
			     "latexmk -pdflatex='xelatex -shell-escape -interaction nonstopmode' -pdf -f  %f"))

(use-package org-pdfview
  :init (pdf-tools-install)
  :bind (:map pdf-view-mode-map
	      ("j" . image-next-line)
	      ("k" . image-previous-line)
	      ("l" . image-forward-hscroll)
	      ("h" . image-backward-hscroll)
	      ("G" . pdf-view-last-page)
	      ("g" . nil)
	      ("gg" . pdf-view-first-page)
	      ("C-c C-c" . image-toggle-display))

  :config
  (setq pdf-view-continuous t)
  (add-to-list 'org-file-apps '("\\.pdf\\'" . org-pdfview-open))
  (add-to-list 'org-file-apps '("\\.pdf::\\([[:digit:]]+\\)\\'" . org-pdfview-open))
  (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode)))

;;archive: 归档已完成的任务
;;每隔一段时间运行一次就行了，会将*.org中的已完成的条目移动到*.orgarchive中。
(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'agenda))

;; (require 'org-download)
;; ;; Drag-and-drop to `dired`
;; (add-hook 'dired-mode-hook 'org-download-enable)

(use-package org-download
  :ensure t 
  ;;将截屏功能绑定到快捷键：Ctrl + Shift + Y
  :bind ("C-S-y" . org-download-clipboard)
  :config
  (require 'org-download)
  ;; Drag and drop to Dired
  (add-hook 'dired-mode-hook 'org-download-enable)
)

;; (setq org-html-htmlize-output-type 'inline-css)
(setq org-html-htmlize-output-type 'css)

;; 导出图片时设置图片size需要用到
(setq org-export-allow-bind-keywords t)

;; 导出PDF时有代码块
(setq org-latex-listings 'minted)
(add-to-list 'org-latex-packages-alist '("" "minted"))

;; 自动换行
;; (add-hook 'org-mode-hook (lambda () (setq toggle-truncate-lines t)))
(global-visual-line-mode 1) ; 1 for on, 0 for off.

(provide 'init-org)
