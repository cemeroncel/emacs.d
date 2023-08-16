;;; ce-biblio.el --- Bibliography management-*- lexical-binding: t; -*-

;; Copyright (C) 2023 Cem Eröncel

;; Author: Cem Eröncel
;; Created: 15 Aug 2023
;; URL:

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
(defvar ce/bibliography-locations '("~/Documents/MyZotero/library.bib")
  "List of .bib file locations.")
(when (string-equal (system-name) "titus")
  (setq ce/bibliography-locations '("~/Documents/MyZotero/library-titus.bib")))

(use-package citar
  :ensure t
  :custom
  ;; Set the locations of the .bib files.
  (citar-bibliography ce/bibliography-locations)

  ;; Configure the `completion-at-point' function to complete citation
  ;; keys in the buffer.
  :hook
  (LaTeX-mode . citar-capf-setup)
  (org-mode . citar-capf-setup)
  )

;; The `citar-embark' package adds contextual access actions in the
;; minibuffer and at-point via the `citar-embark-mode' minor mode.
(use-package citar-embark
  :ensure t
  :after citar embark
  :no-require
  :config (citar-embark-mode))



;;; Code

(provide 'ce-biblio)
;;; ce-biblio.el ends here
