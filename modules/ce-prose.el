;;; ce-prose.el --- Configuration for better prose editing -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Cem Eröncel

;; Author: Cem Eröncel <cemeroncel@gmail.com>
;; Created: 29 Oct 2022
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

;;; Code

;;;; Olivetti mode

(use-package olivetti
  :ensure t
  :commands (olivetti-mode)
  :config
  (customize-set-variable 'olivetti-body-width 85)
  )

;;;; Mixed-pitch
(use-package mixed-pitch
  :ensure t
  :commands (mixed-pitch-mode)
  )

(provide 'ce-prose)
;;; ce-prose.el ends here
