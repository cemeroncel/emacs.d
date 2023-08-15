;;; ce-denote.el --- Denote configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Cem Eröncel

;; Author: Cem Eröncel <cemeroncel@gmail.com>
;; Created: 22 Apr 2023
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

;; This module configures the `Denote' package of Protesilaos Stavrou.

;;; Code

(use-package denote
  :ensure t
  :bind (
         ("C-c d c" . denote-create-note)
         ("C-c d f" . denote-open-or-create)
         )
  :custom
  ;; Directory that store the notes
  (denote-directory (expand-file-name "~/Documents/denote/"))

  ;; List of known keywords
  (denote-known-keywords '("literature" "zettel" "fleeting" "project" "resource"))

  ;; Whether to infer keywords from the filename
  (denote-infer-keywords t)

  ;; Whether to sort keywords in new files. If `nil', they are sorted
  ;; in the order as they are given
  (denote-sort-keywords t)

  ;; Default file extension. `nil' is equivalent to `org'.
  (denote-file-type nil)

  ;; Prompts when creating a new note
  (denote-prompts '(title keywords))

  ;; Regular expression of directories to exclude from all operations.
  (denote-excluded-directories-regexp nil)

  ;; Regular expression of keywords to not infer.
  (denote-excluded-keywords-regexp nil)

  ;; Pick dates, where relevant, with Org's advanced interface:
  (denote-date-prompt-use-org-read-date t)

  ;; Specify the `denote templates' here.

  ;; Whether to allow multi-word keywords:
  (denote-allow-multi-word-keywords nil)

  ;; Whether to show the context of links:
  (denote-backlinks-show-context t)

  :config
  ;; To create a note via the `org-capture'
  (with-eval-after-load 'org-capture
    (add-to-list 'org-capture-templates
                 '("n" "New note (with Denote)" plain
                   (file denote-last-path)
                   #'denote-org-capture
                   :no-save t
                   :immediate-finish nil
                   :kill-buffer t
                   :jump-to-captured t)))
  )

(provide 'ce-denote)
;;; ce-denote.el ends here
