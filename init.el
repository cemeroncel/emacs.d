;; Create `custom.el' if it is not created before. 
(defconst custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))

;; Load `custom.el'
(load custom-file t)

;; Create the `backups' directory if it is not created before.
(defconst backup-dir (concat user-emacs-directory "backups"))
(unless (directory-name-p backup-dir)
  (make-directory backup-dir t))

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(setq sentence-end-double-space nil)

(fset 'yes-or-no-p 'y-or-n-p)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

(tool-bar-mode -1)

(scroll-bar-mode -1)

(setq inhibit-splash-screen t)

(setq gnutls-verify-error t)
(setq tls-checktrust t)

(add-to-list 'default-frame-alist
             '(font . "Source Code Pro-11"))
(setq line-spacing 3)

(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)
(setq scroll-conservatively 101)

(winner-mode t)

(show-paren-mode 1)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package using straight.el
(straight-use-package 'use-package)

;; Always use use-package
(setq straight-use-package-by-default t)

(use-package org
  :straight org-plus-contrib)

(add-hook 'org-mode-hook 'auto-fill-mode)
(setq org-startup-indented t)
(setq org-hide-emphasis-markers t)

(setq org-src-fontify-natively t)

(use-package doom-themes
  :after org
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dracula t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  ;; (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package all-the-icons
  :config
  ;; all the icons doesn't work without font-lock
  ;; and font-lock+ doesn't have autoloads
  (use-package font-lock+
    :straight (:host github :repo "emacsmirror/font-lock-plus")
    :config (require 'font-lock+)))

(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package spaceline
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme)
  )

(use-package diminish)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  )

(use-package swiper
  :after ivy
  :bind ("\C-s" . swiper))

(use-package counsel
  :after ivy
  :bind(
        ("C-c c-r" . ivy-resume)
        ("<f6>" . ivy-resume)
        ("M-x" . counsel-M-x)
        ("C-x C-f" . counsel-find-file)
        ("<f1> f" . counsel-describe-function)
        ("<f1> v" . counsel-describe-variable)
        ("<f1> l" . counsel-find-library)
        ))

(use-package company
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous))
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  )

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))

(use-package avy
  :bind ("M-s" . avy-goto-char))

(use-package yasnippet)

(use-package yasnippet-snippets)

(use-package ace-window
  :bind ("M-o" . ace-window))

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package smartparens
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)
  (smartparens-global-mode))

(use-package tex
  :straight auctex
  :defer t
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil))

(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
(setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))

(use-package cdlatex
  :hook(
        (LaTeX-mode . turn-on-cdlatex)
        (latex-mode . turn-on-cdlatex))
  )

(use-package irony
  :hook ((c++-mode-hook . irony-mode)
         (c-mode-hook . irony-mode)
         (irony-mode-hook . irony-cdb-autosetup-compile-options)))

(use-package company-irony
  :config
  (require 'company)
  (add-to-list 'company-backends 'company-irony))
