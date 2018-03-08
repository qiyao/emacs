(add-to-list 'load-path "~/.emacs.d")

(setq gnus-ignored-newsgroups "")
(setq gnus-permanently-visible-groups ".*")

(setq smtpmail-debug-info t)
(setq smtpmail-debug-verb t)

(require 'smtpmail)
(require 'starttls)

;;(require 'offlineimap)
;;(add-hook 'gnus-before-startup-hook 'offlineimap)
;;(setq offlineimap-mode-line-text "imap: ")

(load-file "~/.emacs.d/gnus-desktop-notify-1.4.el")
(require 'gnus-desktop-notify)
(gnus-desktop-notify-mode)
(gnus-demon-add-scanmail)

(setq message-send-mail-function 'smtpmail-send-it
      ;;smtpmail-starttls-credentials '(("smtp.gmail.com" 587 "qiyaoltc@gmail.com" ""))
      ;;smtpmail-auth-credentials '(("smtp.gmail.com" 587 "qiyaoltc@gmail.com" ""))
      ;smtpmail-default-smtp-server "smtp.gmail.com"
      ;smtpmail-smtp-server "smtp.gmail.com"
      ;smtpmail-smtp-service 587
      smtpmail-default-smtp-server "127.0.0.1"
      smtpmail-smtp-server "127.0.0.1"
      smtpmail-smtp-service 5870
      user-mail-address "qiyaoltc@gmail.com"
      smtpmail-debug-info t
      smtpmail-debug-verb t)

(setq gnus-select-method
      '(nnimap "gmail"
	       ;;(nnimap-address "imap.gmail.com")
	       ;;(nnimap-server-port "imaps")
	       (nnimap-server-port 9930)
	       (nnimap-address "127.0.0.1")
	       (nnimap-inbox "INBOX")
	       (nnimap-stream ssl)))
	       ;; Remove it if we fetch emails from offlineimap.
	       ;;(nnimap-server-port 9930)
;;(nnimap-address "127.0.0.1")

(add-to-list 'gnus-secondary-select-methods
	     '(nnimap "arm"
		       (nnimap-address "outlook.office365.com")
		       (nnimap-server-port 993)
		       (nnimap-stream ssl)))

(add-to-list 'gnus-secondary-select-methods
	       '(nntp "news.gwene.org"))
(add-to-list 'gnus-secondary-select-methods
	       '(nntp "news.gmane.org"))


;(setq smtpmail-debug-info t)
;(setq smtpmail-debug-verb t)
(setq starttls-use-gnutls t)
(setq starttls-gnutls-program "gnutls-cli")
(setq starttls-extra-arguments nil)

(setq gnus-posting-styles
      '((".*"
	 (address "qiyaoltc@gmail.com")
	 (signature "Yao (齐尧)"))
	("nnimap\\+arm:.*"
	 (address "yao.qi@arm.com")
	 (signature "Yao (齐尧)")
	 (X-Message-SMTP-Method "smtp smtp.office365.com 587"))))

(setq gnus-parameters
 '(("INBOX.gdb"
    (visible . t)
    (display . all)))
 )

(setq gnus-message-archive-group
      '(("gmail" "nnimap:Sent")
	("arm" "nnimap\+arm:Sent")
	))

(setq-default
     gnus-summary-line-format "%U%R%z %(%B%s%)  %-15,15n %&user-date;\n"
     gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
     gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
     gnus-thread-sort-functions '(gnus-thread-sort-by-most-recent-date))

;; notification
;;(setq gnus-notifications-use-google-contacts nil)
;;(setq gnus-notifications-use-gravatar nil)
;;(add-hook 'gnus-after-getting-new-news-hook 'gnus-notifications)

;; Collapse threads when entering a group
(add-hook 'gnus-summary-prepared-hook 'gnus-summary-hide-all-threads)

(when (require 'gnus-demon nil t)
  (defun gnus-demon-run-offlineimap ()
    "Scan for new mail/news and update the *Group* buffer."
    (offlineimap)
    (save-window-excursion
      (save-excursion
	(set-buffer gnus-group-buffer)
	(gnus-group-get-new-news)
	)))

  (add-hook 'gnus-group-mode-hook 'gnus-demon-init)
  ;; Check for new mail every 5 minutes (after 2 minute idle)
  ;;(gnus-demon-add-handler 'gnus-demon-run-offlineimap 5 2)
  (gnus-demon-add-handler 'gnus-demon-scan-news 3 2)
  (gnus-demon-add-handler 'gnus-demon-scan-mail 3 2)
  (gnus-demon-add-handler 'gnus-group-get-new-news 3 2)
  )


(setq gnus-treat-highlight-headers 'head   ; Highlight the headers
      gnus-treat-highlight-citation 'last  ; Highlight cited text
      gnus-treat-highlight-signature 'last) ; Highlight the signature

(setq gnus-visible-headers
      '("^From:" "^Subject:" "^To:" "^Cc:" "^Resent-To:" "^Message-ID:"
        "^Date:" "^Organization:" "Followup-To:"
        "Reply-To:" "^X-Newsreader:" "^X-Mailer:"
        "^X-Spam-Level:"))

(gnus-add-configuration
 '(article (horizontal 1.0
		       (vertical 0.15 (group 1.0))
		       (vertical 0.35 (summary 1.0))
		       (vertical 1.0 (article 1.0)))))

(gnus-add-configuration
 '(reply-yank
   (horizontal 1.0
	       (vertical 0.5 (article 1.0))
	       (vertical 1.0 (reply-yank 1.0 )))))

(add-hook 'message-mode-hook (lambda () (flyspell-mode 1)))
(setq gnus-global-score-files
       '("~/News/all.SCORE"))
;; IMAP keep-alive
(setq imap-ping-interval (* 10 60))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(set-face-foreground 'gnus-group-mail-1-face "green")
(set-face-foreground 'gnus-group-mail-1-empty-face "orange")
(set-face-foreground 'gnus-group-mail-2-face "blue")
(set-face-foreground 'gnus-group-mail-2-empty-face "cyan")
(set-face-foreground 'gnus-group-mail-3-face "cyan")
(set-face-foreground 'gnus-group-mail-3-empty-face "white")
(set-face-foreground 'gnus-group-mail-low-face "red")
(set-face-foreground 'gnus-group-mail-low-empty-face "cyan")

(set-face-foreground 'gnus-group-news-1-face "red")
(set-face-foreground 'gnus-group-news-1-empty-face "orange")
(set-face-foreground 'gnus-group-news-2-face "blue")
(set-face-foreground 'gnus-group-news-2-empty-face "cyan")
(set-face-foreground 'gnus-group-news-3-face "SkyBlue")
(set-face-foreground 'gnus-group-news-3-empty-face "Salmon")
(set-face-foreground 'gnus-group-news-4-face "white")
(set-face-foreground 'gnus-group-news-4-empty-face "red")
(set-face-foreground 'gnus-group-news-5-face "beige")
(set-face-foreground 'gnus-group-news-5-empty-face "pink")
(set-face-foreground 'gnus-group-news-6-face "green")
(set-face-foreground 'gnus-group-news-6-empty-face "violet")
(set-face-foreground 'gnus-group-news-low-face "white")
(set-face-foreground 'gnus-group-news-low-empty-face "cyan")

(eval-after-load "gnus-art"
  '(progn
     (set-face-foreground 'gnus-header-content-face "green")
     (set-face-foreground 'gnus-header-from-face "orange")
     (set-face-foreground 'gnus-header-name-face "cyan")
     (set-face-foreground 'gnus-header-newsgroups-face "white")
     (set-face-foreground 'gnus-header-subject-face "white")
     (set-face-foreground 'gnus-signature-face "white")))

(eval-after-load "gnus-cite"
  '(progn
     (set-face-foreground 'gnus-cite-face-1 "blue")
     (set-face-foreground 'gnus-cite-face-2 "red")
     (set-face-foreground 'gnus-cite-face-3 "green")
     (set-face-foreground 'gnus-cite-face-4 "orange")
     (set-face-foreground 'gnus-cite-face-5 "skyblue")
     (set-face-foreground 'gnus-cite-face-6 "violet")
     (set-face-foreground 'gnus-cite-face-7 "salmon")
     (set-face-foreground 'gnus-cite-face-8 "magenta")
     (set-face-foreground 'gnus-cite-face-9 "beige")
     (set-face-foreground 'gnus-cite-face-10 "skyblue")
     (set-face-foreground 'gnus-cite-face-11 "firebrick")))

(defface dz-gnus-own-posting-face
  '((t
     (:foreground "skyblue")))
  "Face used for my postings")

(defface dz-gnus-unread-face
  '((t
     (:foreground "yellow")))
  "Face used for unread emails")

(setq gnus-summary-highlight '())

(add-to-list 'gnus-summary-highlight
             '((> score 6000) . dz-gnus-own-posting-face))

(add-to-list 'gnus-summary-highlight
	     '((and (>= 6000 score) (eq mark gnus-unread-mark)) . dz-gnus-unread-face))

(load-file "~/.emacs.d/gnus/gnus-article-treat-patch.el")
(require 'gnus-article-treat-patch)

(setq gnus-article-patch-conditions
      '( "^@@ -[0-9]+,[0-9]+ \\+[0-9]+,[0-9]+ @@" ))

;;(gnus-compile)
