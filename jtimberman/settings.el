;; Best color theme.
(color-theme-irblack)

;; Use Zsh
(setq shell-file-name "/bin/zsh")

;; Lets have readable fonts for all the times.
(set-default-font "Menlo-14")

;; Away all whitespace!
(global-set-key "\C-cw" 'delete-trailing-whitespace)
(setq show-trailing-whitespace t)

;; Some useful default settings
(setq standard-indent 2)
(setq-default indent-tabs-mode nil)
(line-number-mode 1)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(global-set-key "\C-cc" 'comment-region)
(global-set-key "\C-cu" 'uncomment-region)
(global-set-key "\C-ci" 'indent-region)
;;Don't echo passwords when communicating with interactive programs:
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
;;keep backup files in /tmp
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; cool gist tricks
(require 'gist)

;; markdown for certain files
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.mkd" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.text" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.txt" . markdown-mode) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rvm and ruby
(require 'rvm)
(rvm-use-default)
;; Rake files are ruby, too, as are gemspecs, rackup files, etc.
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Confluence mode with sane longlines
(require 'confluence)

(global-set-key "\C-cg" 'confluence-get-page)
(global-set-key "\C-cs" 'confluence-search)

;; confluence editing support (with longlines mode)
(autoload 'confluence-get-page "confluence" nil t)

 (eval-after-load "confluence"
   '(progn
      (require 'longlines)
      (progn
        (add-hook 'confluence-mode-hook 'longlines-mode)
        (add-hook 'confluence-before-save-hook 'longlines-before-revert-hook)
        (add-hook 'confluence-before-revert-hook 'longlines-before-revert-hook)
        (add-hook 'confluence-mode-hook '(lambda () (local-set-key "\C-j" 'confluence-newline-and-indent))))))

 (autoload 'longlines-mode "longlines" "LongLines Mode." t)

 (eval-after-load "longlines"
   '(progn
      (defvar longlines-mode-was-active nil)
      (make-variable-buffer-local 'longlines-mode-was-active)

      (defun longlines-suspend ()
        (if longlines-mode
            (progn
              (setq longlines-mode-was-active t)
              (longlines-mode 0))))

      (defun longlines-restore ()
        (if longlines-mode-was-active
            (progn
              (setq longlines-mode-was-active nil)
              (longlines-mode 1))))

      ;; longlines doesn't play well with ediff, so suspend it during diffs
      (defadvice ediff-make-temp-file (before make-temp-file-suspend-ll
                                              activate compile preactivate)
        "Suspend longlines when running ediff."
        (with-current-buffer (ad-get-arg 0)
          (longlines-suspend)))

      (add-hook 'ediff-cleanup-hook
                '(lambda ()
                   (dolist (tmp-buf (list ediff-buffer-A
                                          ediff-buffer-B
                                          ediff-buffer-C))
                     (if (buffer-live-p tmp-buf)
                         (with-current-buffer tmp-buf
                           (longlines-restore))))))))
