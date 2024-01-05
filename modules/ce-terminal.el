;;; ce-terminal.el --- Enhanced terminal experience -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Cem Eröncel

;; Author: Cem Eröncel
;; Created:  4 Dec 2023
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

;; This module provides enhanced terminal experience using vterm.  In
;; order this module to work, Emacs needs to be built with the module
;; support, which can be verified by checking that
;; `module-file-suffix' is not `nil'. The following libraries are also
;; needed
;; - cmake (>=3.11)
;; - libtool-bin
;; - libvterm (>=0.2)

;;; Code

(use-package vterm
  :ensure t)

(provide 'ce-terminal)
;;; ce-terminal.el ends here
