(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; list the packages you want
(defvar package-list)
(setq package-list '(company
                     company-irony
			         company-irony-c-headers
			         company-jedi
			         popup
			         xcscope
			         color-theme-sanityinc-tomorrow
			         magit-popup
			         eyebrowse
                     use-package
                 ))
;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))
;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; set font-lock
(global-font-lock-mode 1)
;;(load-file "~/.emacs.d/gdb-hack.el")
;;(load-file "/home/yao/SourceCode/gnu/gdb/git/gdb/gdb/gdb-code-style.el")

;; high-light the marked region.
(setq mark-command t)
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "C-.") 'set-mark-command)

;;; I prefer cmd key for meta
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)
;; customize the color of it
;;(setq hl-line-mode t)

(setq inhibit-startup-message t)
;;
;; show colum number
(setq column-number-mode t)
;; set number in each line
(setq fill-column 72)

(setq enable-local-variables :all)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; send mail
(setq user-full-name "Yao Qi")
(setq user-mail-address "yao.qi@linaro.org")


(setq gnus-init-file "~/.emacs.d/gnus/gnus.el")
;;(setq gnus-startup-file "~/.emacs.d/gnus/newsrc")


(put 'set-goal-column 'disabled nil)

(require 'whitespace)
;;(add-hook 'c-mode-hook 
;;    (lambda()
;;       (load-file "/home/yao/.emacs.d/whitespace.el")))
(add-hook 'diff-mode-hook 'whitespace-mode)
(add-hook 'tcl-mode-hook 'whitespace-mode)

;;(setq Info-default-directory-list (append (list "/home/qiyao/bin/info/") Info-default-directory-list))
;; print
(setq ps-print-header nil)
(setq ps-header-lines 0)

(show-paren-mode t)

(add-hook 'c-mode-common-hook 'whitespace-mode)
(add-hook 'c-mode-common-hook 'cscope-minor-mode)

; Yao hates the tmp file
(setq-default make-backup-files nil)
;; No bell
(setq visible-bell t)

;(create-fontset-from-fontset-spec
; "-b&h-lucidatypewriter-medium-r-normal-sans-24-140-100-100-m-100-fontset-courier")
;;  "-*-courier-medium-o-normal-*-34-*-*-*-*-*-fontset-courier")
;;(set-default-font "fontset-courier")
;(setq default-frame-alist
;      (append
;       '((font . "fontset-courier")) default-frame-alist))

(require 'xcscope) ;;
(cscope-setup)

;; highlight a region under X.
(transient-mark-mode t)

(global-set-key (kbd "M-g g") 'goto-line)

(global-set-key (kbd "C-x p") (lambda ()
                                (interactive)
                                (other-window -1)))

;; Template for displaying mode line for current buffer.
(setq default-mode-line-format
      ( list ""
        'mode-line-modified
        "[%b]"
        'global-mode-string
        "%[("
        'mode-name
        mode-line-process
        minor-mode-alist
        "%n" ")%]--"
;;        '(line-number-mode "L%l--")
;;        '(column-number-mode "C%c--")
	"L%l--"
	"C%c--"
;;        (-3 . "%p")  ;; position
        user-login-name "@" system-name  ;; you@host.domain.org
;        user-login-name "@" hostname  ;;  you@host
        ":"
        "%f"  ;; print file with full path
;        (:eval buffer-file-truename)  ;; print file with abbreviated path
        " %-"
        ) )

(setq mode-line-format default-mode-line-format)

(set-face-foreground 'mode-line-inactive "white")
(set-face-background 'mode-line-inactive "blue")

(set-face-foreground 'mode-line "white")
(set-face-background 'mode-line "red")

(set-face-background 'vertical-border "green")
(set-face-foreground 'vertical-border (face-background 'vertical-border))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

(defun tabbar-buffer-groups ()
   "Return the list of group names the current buffer belongs to.
 This function is a custom function for tabbar-mode's tabbar-buffer-groups.
 This function group all buffers into 3 groups:
 Those Dired, those user buffer, and those emacs buffer.
 Emacs buffer are those starting with “*”."
   (list
    (cond
     ((string-equal "*" (substring (buffer-name) 0 1))
      '("Emacs Buffer")
      )
     ((eq major-mode 'dired-mode)
      '("Dired")
      )
     (t
      '("User Buffer")
      )
     ))) ;; from Xah Lee
 (setq tabbar-buffer-groups-function 'tabbar-buffer-groups)


;color-theme
;;(add-to-lnist 'load-path "~/.emacs.d")
;(require 'color-theme)
(setq color-theme-is-global t)
;;(color-theme-initialize)
;(color-theme-calm-forest)
;(color-theme-blue-mood)
;(color-theme-blue-sea)
;(color-theme-classic)
;;(color-theme-dark-blue2)
;;(color-theme-sitaramv-solaris)
;;(color-theme-tty-dark)
;;(color-theme-jsc-light)
;;(eval-after-load "color-theme" '(color-theme-dark-laptop))
;;(load-theme sanityinc-tomorrow-blue)

(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow--define-theme blue)
;;(eval-after-load "color-theme" '(color-theme-dark-blue2))
;(color-theme-bharadwaj-slate)
;(color-theme-billw)
;(euphoria)
;(hober)

(windmove-default-keybindings)

;; spell check
;(add-hook 'c-mode-common-hook
;          (lambda ()
;            (flyspell-prog-mode)
;          ))

;(add-hook 'change-log-mode-hook
;          (lambda ()
;            (flyspell-prog-mode)
;          ))
;;(add-hook 'tcl-mode-hook emacs-lisp-mode-hook
(setq ispell-dictionary "american")
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'change-log-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'diff-mode-hook 'flyspell-mode)

(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(setq w3m-default-display-inline-images t)

(defun flyspell-emacs-popup-textual (event poss word)
  "A textual flyspell popup menu."
  (require 'popup)
  (let* ((corrects (if flyspell-sort-corrections
                       (sort (car (cdr (cdr poss))) 'string<)
                     (car (cdr (cdr poss)))))
         (cor-menu (if (consp corrects)
                       (mapcar (lambda (correct)
                                 (list correct correct))
                               corrects)
                     '()))
         (affix (car (cdr (cdr (cdr poss)))))
         show-affix-info
         (base-menu  (let ((save (if (and (consp affix) show-affix-info)
                                     (list
                                      (list (concat "Save affix: " (car affix))
                                            'save)
                                      '("Accept (session)" session)
                                      '("Accept (buffer)" buffer))
                                   '(("Save word" save)
                                     ("Accept (session)" session)
                                     ("Accept (buffer)" buffer)))))
                       (if (consp cor-menu)
                           (append cor-menu (cons "" save))
                         save)))
         (menu (mapcar
                (lambda (arg) (if (consp arg) (car arg) arg))
                base-menu)))
    (cadr (assoc (popup-menu* menu :scroll-bar t) base-menu))))

(defun flyspell-emacs-popup-choose (org-fun event poss word)
  (if (display-popup-menus-p)
      (funcall org-fun event poss word)
    (flyspell-emacs-popup-textual event poss word)))

(eval-after-load "flyspell"
  '(progn
     (advice-add 'flyspell-emacs-popup :around #'flyspell-emacs-popup-choose)))

(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 4
				  tab-width 4
				  indent-tabs-mode nil)))

(defun my-java-mode-hook ()
  (setq c-basic-offset 4
	tab-width 4
	indent-tabs-mode nil)
  (eclim-mode t))

(add-hook 'java-mode-hook 'my-java-mode-hook)

(require 'company)
(global-company-mode t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white")))))

(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "M-/") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "C-n") 'company-select-next)
     (define-key company-active-map (kbd "C-p") 'company-select-previous)))

(add-hook 'python-mode-hook
	  (lambda ()
	    (setq company-backends '((company-jedi
				                  company-yasnippet ;; Comment out this line and the follow one should find some differences
				                  company-files ;;
				                  company-dabbrev-code
				                  company-gtags
				                  company-etags
				                  company-keywords)
				                 company-dabbrev))))
(add-hook 'python-mode-hook (lambda ()
                              (require 'sphinx-doc)
                              (sphinx-doc-mode t)))
(setq python-shell-interpreter "python3")

;; Company appears to override the above keymap based on company-auto-complete-chars.
;; Turning it off ensures we have full control.
(setq company-auto-complete-chars nil)

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(setq w3m-default-display-inline-images t)

(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))

(setq magit-diff-paint-whitespace-lines "all")
(setq magit-diff-paint-whitespace t)
(setq magit-diff-refine-ignore-whitespace nil)
(setq magit-diff-refine-hunk nil)
(setq magit-diff-highlight-indentation 1)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("shell" (or (mode . shell-mode)
                            (mode . eshell-mode)))
               ("magit" (or
                         (mode . magit-status-mode)
                         (mode . magit-process-mode)
                         (mode . magit-diff-mode)
                         (mode . magit-revision-mode)
                         (mode . magit-log-mode)
                         ))
               ("programming" ;;
                (or
                 (mode . c-mode)
                 (mode . c++-mode)
                 (mode . perl-mode)
                 (mode . python-mode)
                 (mode . emacs-lisp-mode)))
               ("directories"
                (mode . dired-mode))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")))
               ))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

(eyebrowse-mode t)

(use-package eww
  :config
  (progn
    (defvar modi/eww-google-search-url "https://www.google.com/search?q="
      "URL for Google searches.")
    (setq eww-search-prefix modi/eww-google-search-url)
    ;; (setq eww-search-prefix "https://duckduckgo.com/html/?q=")
    (setq eww-download-directory "~/Downloads")
    (setq eww-form-checkbox-symbol "[ ]")
    ;; (setq eww-form-checkbox-symbol "☐") ; Unicode hex 2610
    (setq eww-form-checkbox-selected-symbol "[X]")
    ;; (setq eww-form-checkbox-selected-symbol "☑") ; Unicode hex 2611
    ;; Improve the contract of pages like Google results
    ;; http://emacs.stackexchange.com/q/2955/115
    (setq shr-color-visible-luminance-min 80) ; default = 40
    ))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-source-save-behavior nil)
 '(package-selected-packages
   (quote
    (metaweblog auto-complete ggtags company-irony-c-headers company-irony company-c-headers)))
 '(weblogger-config-alist
   (quote
    (("default"
      ("user" . "yaoqi")
      ("server-url" . "https://yaoqi.wordpress.com/xmlrpc.php")
      ("weblog" . "16293080"))))))
