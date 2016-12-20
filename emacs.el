(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)


(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends (delete 'company-semantic company-backends))
(setq company-clang-executable "/usr/bin/clang-3.5")

(require 'whitespace)
;;(add-hook 'c-mode-hook 
;;    (lambda()
;;       (load-file "/home/yao/.emacs.d/whitespace.el")))
(add-hook 'diff-mode-hook 'whitespace-mode)
(add-hook 'tcl-mode-hook 'whitespace-mode)

(show-paren-mode t)

;; Customizations for all modes in CC Mode.
(defun my-c-initialization-hook ()
  (define-key c-mode-base-map (kbd "M-/") 'company-complete)
  (add-hook 'c-mode-common-hook 'hs-minor-mode)
  (add-hook 'c-mode-common-hook 'whitespace-mode)
  (add-hook 'c-mode-common-hook 'irony-mode)
  (add-hook 'c-mode-common-hook 'cscope-minor-mode)
  ;; (add-to-list 'company-backends 'company-irony-c-headers company-irony)
  )
(add-hook 'c-initialization-hook 'my-c-initialization-hook)

(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony company-c-headers)))

; Yao hates the tmp file
(setq-default make-backup-files nil)
;; No bell
(setq visible-bell t)

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

(setq ispell-dictionary "american")
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'change-log-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)
(add-hook 'diff-mode-hook 'flyspell-mode)

