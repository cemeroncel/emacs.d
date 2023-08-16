;;; early-init.el --- Main init file -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Cem Eröncel

;; Author: Cem Eröncel
;; Created: 21 Jul 2023
;; Last update: 6 Aug 2023
;; URL: https://github.com/cemeroncel/emacs.d
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1"))

;; This file is NOT part of GNU Emacs.

;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later
;;
;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <https://www.gnu.org/licenses/>.

;;; Commentary

;;; Code

;; use name and e-mail address
(setq user-full-name "Cem Eröncel"
      user-mail-address "cemeroncel@gmail.com")

;; Starting from Emacs 28.1, gnu elpa and nongnu elpa are included in
;; the `package-archives' list by default. We only need to add melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Set the preferred channels to download the packages. 
(customize-set-variable 'package-archive-priorities
			'(("gnu"    . 99)
			  ("nongnu" . 80)
			  ("melpa" . 70))
			)

;; Save customizations to an external file instead of init.el. Load
;; this file if it exists. We load this early so that any
;; customization we state in our configuration can override what's in
;; the custom.el file, but at the same time the customizations that we
;; miss in our configuration are loaded as well.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;; (when (and custom-file
;; 	   (file-exists-p custom-file))
;;   (load custom-file nil 'nomessage))


;; Use the `no-littering' package to keep the emacs directory
;; clean. We need to load this at an early phase so that all of our
;; configuration can make use of this.
(use-package no-littering
  :ensure t
  :config
  ;; Exclude all of the files in the `no-littering' directories when
  ;; using `recentf'
  (require 'recentf)
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-var-directory))
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-etc-directory))
  ;; Put the files created by auto save, backup, and `undo-tree' also
  ;; to the `no-littering-var-directory'
  (no-littering-theme-backups)
  )

;;;; Font configuration
(defvar ce/font-height 130
  "Font height that will be passed to `set-face-attribute'.")

(when (string-equal (system-name) "titus")
  (setq ce/font-height 140))

;; Main typeface
(set-face-attribute 'default nil :family "Iosevka" :height ce/font-height)

;; Proportionately spaced typeface
(if (string-equal (system-name) "titus")
    (set-face-attribute 'variable-pitch nil :family "Iosevka Etoile" :height ce/font-height)
  (set-face-attribute 'variable-pitch nil :family "Iosevka Aile" :height ce/font-height)
  )

;; Monospaced typeface
(set-face-attribute 'fixed-pitch nil :family (face-attribute 'default :family))

;;;; Custom modules
;; Define a variable for the custom modules and add them to the `load-path'
(defvar ce/modules-directory (expand-file-name "modules/" user-emacs-directory)
  "The directory that store custom lisp modules.")
(add-to-list 'load-path ce/modules-directory)

;; List of custom modules
(require 'ce-biblio)                    ; Bibliography management in Emacs
(require 'ce-colors)                    ; make Emacs more colorful
(require 'ce-completion)		; modern completion mechanism
(require 'ce-defaults)			; better defaults for Emacs
(require 'ce-denote)                    ; Note taking Prot's way
(require 'ce-git)                       ; Magit
(require 'ce-help)                      ; More helpful help buffers
(require 'ce-latex)                     ; for doing science
;; (require 'ce-markdown)             ; for README
(require 'ce-org)                       ; Org Mode configuration
(require 'ce-prose)                     ; for prose editing
;; (require 'ce-theming-modus)             ; Modus themes
(require 'ce-theming-ef)
(require 'ce-tools-pdf)                 ; PDF reading and annotation

;;; init.el ends here

