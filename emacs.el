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
			         eclim company-emacs-eclim
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
(global-set-key (kbd "M-SPC") 'set-mark-command)
;; customize the color of it
;;(setq hl-line-mode t)

(setq inhibit-startup-message t)
;;
;; show colum number
(setq column-number-mode t)
;; set number in each line
(setq fill-column 72)

(setq enable-local-variables :all)

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


(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))

;; egg;
(add-to-list 'load-path "~/.emacs.d/egg/")
(require 'egg)

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
;;(add-to-list 'load-path "~/.emacs.d")
(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
;(color-theme-calm-forest)
;(color-theme-blue-mood)
;(color-theme-blue-sea)
;(color-theme-classic)
;;(color-theme-dark-blue2)
;;(color-theme-sitaramv-solaris)
;;(color-theme-tty-dark)
;;(color-theme-jsc-light)
(eval-after-load "color-theme" '(color-theme-dark-laptop))
;;(eval-after-load "color-theme" '(color-theme-dark-blue2))
;(color-theme-bharadwaj-slate)
;(color-theme-billw)
;(euphoria)
;(hober)

(require 'org)
(setq org-log-done 'time)

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

;;org2blog

(require 'org2blog-autoloads)
(require 'xml-rpc)
(setq org2blog/wp-blog-alist
      '(("wordpress"
         :url "https://yaoqi.wordpress.com/xmlrpc.php"
         :username "yaoqi"
         :default-title ""
         :default-categories "my-default category"
         :tags-as-categories nil)
	))
(setq org2blog/wp-buffer-template
      "-----------------------
#+TITLE: %s
#+DATE: %s
#+CATEGORY:
#+TAGS:
-----------------------\n")
(defun my-format-function (format-string)
  (format format-string
          org2blog/wp-default-title
          (format-time-string "[%Y-%m-%d]" (current-time))))
(setq org2blog/wp-buffer-format-function 'my-format-function)
(setq org-src-fontify-natively t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

(setq org2blog/wp-use-sourcecode-shortcode 't)

;; company
(load-file "~/.emacs.d/company.el")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


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
