;;set up MELPA for package installation
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)


;; Set style to Google C style
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode)) ;; make sure .h files are treated like c++ files
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'google-c-style)
(defun my-c-mode-hook ()
  (google-set-c-style)
  (setq c-basic-offset 4 
        indent-tabs-mode t 
        default-tab-width 4))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)
;; If you want the RETURN key to go to the next line and space over
;; to the right place, add this to your .emacs right after the load-file:
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;;autopair: insert closing parens automatically
;;(add-to-list 'load-path "/path/to/autopair")
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers

;; adding cua-mode allows for replacement of highlighted section
(setq cua-enable-cua-keys nil)           ;; don't add C-x,C-c,C-v
(cua-mode t)                             ;; for rectangles, CUA is nice

;;change behavior of C-a
;;"Move point to the beginning of text on the current line; if that is already
;;the current position of point, then move it to the beginning of the line."
(defun smart-line-beginning ()
  (interactive)
  (let ((pt (point)))
    (beginning-of-line-text)
    (when (eq pt (point))
      (beginning-of-line))))
(add-hook 'c-mode-common-hook
          (lambda ()
            (define-key c-mode-base-map "\C-a" 'smart-line-beginning)))
;;(eval-after-load 'google-c-style 
;;    '(define-key c-mode-base-map (kbd "C-a") 'smart-line-beginning))

;; blink matching parenthesis pairs
(require 'mic-paren)
(paren-activate)
(add-hook 'LaTeX-mode-hook
		  (function (lambda ()
					  (paren-toggle-matching-quoted-paren 1)
					  (paren-toggle-matching-paired-delimiter 1))))

(add-hook 'c-mode-common-hook
		  (function (lambda ()
					  (paren-toggle-open-paren-context 1))))
;;(show-paren-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-safe-themes
   (quote
	("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(package-selected-packages (quote (color-theme-sanityinc-tomorrow company)))
 '(paren-display-message (quote always))
 '(paren-message-show-linenumber (quote absolute)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;;set custom theme
(require 'color-theme-sanityinc-tomorrow)
