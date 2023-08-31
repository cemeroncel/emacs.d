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
;;;; Definitions
(defvar ce/bibliography-locations '("~/Documents/MyZotero/library.bib")
  "List of .bib file locations.")
(when (string-equal (system-name) "titus")
  (setq ce/bibliography-locations '("~/Documents/MyZotero/library-titus.bib")))

;;;; Citar
(use-package citar
  :ensure t
  ;; Replace the impossible to remember C-c C-x C-@ keybinding to
  ;; insert a citation in org-mode.
  :bind
  (:map org-mode-map :package org ("C-c b" . #'org-cite-insert))
  :custom
  ;; Set the locations of the .bib files.
  (citar-bibliography ce/bibliography-locations)

  ;; Org-mode related settings
  (org-cite-global-bibliography ce/bibliography-locations)
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  
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

;;;; citar-denote
;; This auxilliary package integrates the Citar with Denote.
(use-package citar-denote
  :ensure t
  :after citar denote
  :bind (
         ;; Create a new bibliographic note.
         ("C-c n c c" . citar-create-note)
         ;; Open existing bibliographic note.
         ("C-c n c o" . citar-denote-open-note)
         ;; Open attachments, URLs or other associated notes.
         ("C-c n c d" . citar-denote-dwim)
         ;; Convert existing notes to bibliographic notes
         ("C-c n c a" . citar-denote-add-citekey)
         ;; Remove references from bibliographic notes
         ("C-c n c k" . citar-denote-remove-citekey)
         ;; Open bibliographic source file
         ("C-c n c e" . citar-denote-open-reference-entry)
         ;; Find Denote file citing the current reference(s)
         ("C-c n c r" . citar-denote-find-reference)
         ;; Find a citation in Denote files
         ("C-c n c f" . citar-denote-find-citation)
         ;; Cite entries not referenced or cited in any note
         ("C-c n c n" . citar-denote-cite-nocite)
         ;; Create a new note for entries not referenced or cited in any note.
         ("C-c n c m" . citar-denote-reference-nocite)
         ;; Link to a bibliographic note
         ("C-c n c l" . citar-denote-link-reference)
         )
  :custom
  ;; The default name for a new note. `nil' means the BibTeX citation key.
  (citar-denote-title-format nil)
  ;; Offer to create notes even for keys that already have notes.
  (citar-open-always-create-notes t)
  :config
  (citar-denote-mode)
  )

;;; Code

(provide 'ce-biblio)
;;; ce-biblio.el ends here
