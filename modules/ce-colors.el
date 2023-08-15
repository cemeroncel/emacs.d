;;; ce-colors.el --- Make Emacs more colorful -*- lexical-binding: t; -*-

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

;; This module makes Emacs more colorful. Uses `rainbow-delimiters'
;; <https://github.com/Fanael/rainbow-delimiters> to colorize the
;; matching parantheses with the same color, and `rainbow-mode' which
;; colorize color names in buffers.

;;; Code

;;;; Rainbow delimiters

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

;;;; Rainbow mode
(use-package rainbow-mode
  :ensure t
  :commands (rainbow-mode))

(provide 'ce-colors)
;;; ce-colors.el ends here
