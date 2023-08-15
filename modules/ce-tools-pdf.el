;;; ce-tools-pdf.el --- PDF Tools configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Cem Eröncel

;; Author: Cem Eröncel <cemeroncel@gmail.com>
;; Created: 31 Oct 2022
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

;; This module configures pdf-tools <https://github.com/vedang/pdf-tools>

;;; Code

(use-package pdf-tools
  :ensure t
  :pin melpa
  :config
  (add-hook 'doc-view-mode-hook (lambda () (require 'pdf-tools)))
  (pdf-loader-install)
  (setq-default pdf-view-display-size 'fit-width)
  )

(provide 'ce-tools-pdf)
;;; ce-tools-pdf.el ends here
