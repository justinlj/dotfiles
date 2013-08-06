;; (defadvice push-mark (around semantic-mru-bookmark activate)
;;   "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
;; If `semantic-mru-bookmark-mode' is active, also push a tag onto
;; the mru bookmark stack."
;;   (semantic-mrub-push semantic-mru-bookmark-ring
;; 		      (point)
;; 		      'mark)
;;   ad-do-it)

(defun semantic-ia-fast-jump-back ()
  (interactive)
  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
      (error "Semantic Bookmark ring is currently empty"))
  (let* ((ring (oref semantic-mru-bookmark-ring ring))
	 (alist (semantic-mrub-ring-to-assoc-list ring))
	 (first (cdr (car alist))))
    (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
	(setq first (cdr (car (cdr alist)))))
    (semantic-mrub-switch-tags first)))

;; (defun $subdirs-to-list (default-directory)
;;   (when (file-directory-p default-directory)
;;     (let ((normal-top-level-add-subdirs-inode-list (list))
;; 	  (load-path (list nil)))
;;       (append
;;        (copy-sequence (normal-top-level-add-to-load-path (list ".")))
;;        (normal-top-level-add-subdirs-to-load-path)))))

;; (setq load-path
;;       (apply 'append
;; 	     ($subdirs-to-list (expand-file-name "~/share/emacs/site-lisp/"))
;; 	     **default-load-path**
;; ;; Enable contributed extensions to org-mode on Debian
;; 	     (list "/usr/share/org-mode/lisp")
;; 	     (mapcar '$subdirs-to-list
;; 		     (let* ((default-directory user-emacs-directory))
;; 		       (mapcar 'expand-file-name '("themes/" "site-lisp/"))))))
;;-------------------------括号匹配--------------------------
;;括号匹配时显示另一端的括号，而不是跳过去
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;;-------------------------语法加亮--------------------------
(global-font-lock-mode t)
;;C默认格式为linux
(add-hook 'c-mode-hook
'(lambda()
(c-set-style "linux")))
;;取消开机画面
(setq inhibit-startup-message t)
;;-------------------------显示列号--------------------------
;;(setq column-number-mode t)
;;display the column number and line number
(setq column-number-mode t)
(setq line-number-mode t)
;;-------------------------标题拦显示buffer的名字------------
;;(setq frame-title-format "emacs@%b")
;Emacs title bar to reflect file name
;(defun frame-title-string ()
;"Return the file name of current buffer, using ~ if under home directory"
;(let
;((fname (or
;(buffer-file-name (current-buffer))
;(buffer-name))))
;;let body
;(when (string-match (getenv "HOME") fname)
;(setq fname (replace-match "~" t t fname)) )
;　　 fname))
; (defun display-buffer-name ()
;   (interactive)
;  (message (buffer-file-name (current-buffer))))
;;; Title = 'system-name File: foo.bar'
;(setq frame-title-format '("" system-name " File: "(:eval (frame-title-string))))
(defun frame-title-string ()
"Return the file name of current buffer, using ~ if under home directory"
(let ((fname (or (buffer-file-name (current-buffer)) (buffer-name))))
;;let body
(when (string-match (getenv "HOME") fname)
(setq fname (replace-match "~" t t fname)) )
fname))
;;; Title = 'system-name File: foo.bar'
(setq frame-title-format '("" system-name " File: "(:eval (frame-title-string))))
;;-------------------------设置emacs启动时初始化大小-------------------------
;;(setq initial-frame-alist '((top . 0) (left . 0) (width . 1280) (height . 1024)))

;字体设置
;(set-default-font "YaHeiConsolas-13")
;(set-fontset-font "fontset-default"
;                  'unicode '("YaHeiConsolas-13" . "unicode-bmp"))
;(setq default-frame-alist
;      (append '((font . "YaHeiConsolas-13")) default-frame-alist))
;解决emacs shell 乱码
(setq ansi-color-for-comint-mode t)
(customize-group 'ansi-colors)
(kill-this-buffer);关闭customize窗口
;自定义按键
(global-set-key [f1] 'shell);F1进入Shell
(global-set-key [f5] 'gdb);F5调试程序
(setq compile-command "make -f Makefile")
(global-set-key [f7] 'do-compile);F7编译文件
(global-set-key [f8] 'other-window);F8窗口间跳转
(global-set-key [C-return] 'kill-this-buffer);C-return关闭当前buffer
(global-set-key [f10] 'split-window-vertically);F10分割窗口
(global-set-key [f11] 'delete-other-windows);F11 关闭其它窗口
;(global-set-key [f12] 'my-fullscreen);F12 全屏
(global-set-key [f12] 'semantic-ia-fast-jump)
(global-set-key [S-f12] 'semantic-ia-fast-jump-back)
;;(global-set-key (kbd "C-,") 'backward-page);文件首
;;(global-set-key (kbd "C-.") 'forward-page);文件尾

;;全屏
;(defun my-fullscreen ()
;  (interactive)
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;最大化
;(defun my-maximized-horz ()
;  (interactive)
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
;(defun my-maximized-vert ()
;  (interactive)
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
;(defun my-maximized ()
;  (interactive)
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;  (interactive)
;  (x-send-client-message
;   nil 0 nil "_NET_WM_STATE" 32
;   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
;(my-maximized)
;;-------------------------设置Emacs的前景色和背景色(手工设置)-------------------------
(setq default-frame-alist
'(
  (foreground-color . "Wheat")
  (background-color . "DarkSlateGray")
  (cursor-color . "green1")
  ) ls
)
;; -------------------------将文件模式和文件后缀关联起来。append表示追加-------------------------
(
setq auto-mode-alist
    ( append
        '(("\\.py\\'" . python-mode)
        ("\\.s?html?\\'" . html-helper-mode)
        (" \\.asp\\'" . html-helper-mode)
        ("\\.phtml\\'" . html-helper-mode)
        ("\\.css\\'" . css-mode)
        ("\\.pc$" . c-mode)
    )
auto-mode-alist))
;;------------------------------------其它设置---------------------------------------
;;(setq default-major-mode 'text-mode);一打开就起用 text 模式。
(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no，可能你觉得不需要，呵呵。
(display-time-mode 1);显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(tool-bar-mode nil);去掉那个大大的工具栏
(scroll-bar-mode nil);去掉滚动条，因为可以使用鼠标滚轮了 ^_^
(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(transient-mark-mode t);
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
(setq default-fill-column 80);默认显示 80列就换行
;;(setq-default make-backup-files nil);不要生成临时文件
(setq track-eol t);當光標在行尾上下移動的時候，始終保持在行尾。
(setq scroll-margin 3 scroll-conservatively 10000);防止頁面滾動時跳動  scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文。
(setq mouse-yank-at-point t);中鍵粘貼
;;(setq require-final-newline t);; 自动的在文件末增加一新行

(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)


(load-file "~/.emacs.d/site-lisp/emacs-for-python/epy-init.el")
(setq load-path (cons "~/.emacs.d/" load-path))
;; (setq auto-mode-alist
;;       (cons '("\\.py$" . python-mode) auto-mode-alist))
;; (setq interpreter-mode-alist
;;       (cons '("python" . python-mode)
;;     interpreter-mode-alist))
;; (autoload 'python-mode "python-mode" "Python editing mode." t)
;;; add these lines if you like color-based syntax highlighting

;(global-font-lock-mode t)

;(setq font-lock-maximum-decoration t)

;(set-language-environment 'Chinese-GB)

;(set-keyboard-coding-system 'euc-cn)

;(set-clipboard-coding-system 'euc-cn)

;(set-terminal-coding-system 'euc-cn)

;(set-buffer-file-coding-system 'euc-cn)

;(set-selection-coding-system 'euc-cn)

;(modify-coding-system-alist 'process "*" 'euc-cn)

;(setq default-process-coding-system

; '(euc-cn . euc-cn))

;(setq-default pathname-coding-system 'euc-cn)
;(add-hook 'c-mode-hook (global-ede-mode 1))
;(add-hook 'c-mode-hook (global-semantic-highlight-edits-mode (if window-system 1 -1)))
;(add-hook 'c-mode-hook (global-semantic-show-unmatched-syntax-mode))
;(add-hook 'c-mode-hook (global-semantic-show-parser-state-mode 1))
;; (setq semanticdb-project-roots (list (expand-file-name "/")))
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "../src"
	"../.." "../../include" "../../inc" "../../common" "../../public" "../../src"))
(defconst cedet-win32-include-dirs
  (list "C:/MinGW/include"
	"C:/MinGW/include/c++/3.4.5"
	"C:/MinGW/include/c++/3.4.5/mingw32"
	"C:/MinGW/include/c++/3.4.5/backward"
	"C:/MinGW/lib/gcc/mingw32/3.4.5/include"
	"C:/Program Files/Microsoft Visual Studio/VC98/MFC/Include"))
(defconst cedet-linux-include-dirs
  (list "/usr/include"
	"/usr/include/apr-1"
	"/usr/local/include"))
(require 'semantic nil 'noerror)
(let ((include-dirs cedet-user-include-dirs))
  (when (eq system-type 'windows-nt)
    (setq include-dirs (append include-dirs cedet-win32-include-dirs)))
  (when (eq system-type 'gnu/linux)
    (setq include-dirs (append include-dirs cedet-linux-include-dirs)))
  (mapc (lambda (dir)
	  (semantic-add-system-include dir 'c++-mode)
	  (semantic-add-system-include dir 'c-mode))
	include-dirs))
;;fci
(add-to-list 'load-path "~/.emacs.d/site-lisp/Fill-Column-Indicator")
(require 'fill-column-indicator)
(add-hook 'c-mode-hook (lambda()(fci-mode 1)))
;;CEDET
(setq ede-auto-add-method 'never)
(add-hook 'c-mode-hook (lambda()(global-ede-mode 1)))
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
				  global-semanticdb-minor-mode
				  global-semantic-idle-summary-mode
				  global-semantic-mru-bookmark-mode
				  global-semantic-idle-completions-mode
				  global-semantic-highlight-func-mode
				  ))
(add-hook 'c-mode-hook (lambda()
			 (global-semantic-show-unmatched-syntax-mode
			  (if window-system 1 -1))))
(add-hook 'c-mode-hook (lambda()
			 (global-semantic-show-parser-state-mode
			  (if window-system 1 -1))))
(add-hook 'c-mode-hook (lambda()
			 (global-semantic-highlight-edits-mode
			  (if window-system 1 -1))))
(add-hook 'c-mode-hook (lambda()
			 (global-semantic-idle-local-symbol-highlight-mode
			  (if window-system 1 -1))))
(add-hook 'c-mode-hook (lambda()(semantic-mode 1)))
;;auto highlight symbol
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-highlight-symbol-mode")
;;(require 'auto-highlight-symbol)
;;(add-hook 'c-mode-hook (lambda()(global-auto-highlight-symbol-mode 1)))
;
;(global-set-key [(control f3)] 'highlight-symbol-at-point)
;(global-set-key [f3] 'highlight-symbol-next)
;(global-set-key [(shift f3)] 'highlight-symbol-prev)
;(global-set-key [(meta f3)] 'highlight-symbol-prev)))
;;whitespace-style
;; (setq-default show-trailing-whitespace t) ; use whitespace-mode instead
;(setq whitespace-style '(face trailing lines-tail newline empty tab-mark))
(setq whitespace-style '(face trailing newline empty tab-mark tabs newline-mark))
(when window-system
  (setq whitespace-style (append whitespace-style '(tabs newline-mark))))
(global-whitespace-mode t)
(eval-after-load "whitespace"
  `(defun whitespace-post-command-hook ()
     "Hack whitespace, it's very slow in c++-mode."))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ede-project-directories (quote ("/tmp/myproject/src" "/tmp/myproject/include" "/tmp/myproject" "/tmp/project"))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(put 'set-goal-column 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
