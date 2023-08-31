;;; ce-eglot.el --- General eglot settings -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Cem Eröncel

;; Author: Cem Eröncel
;; Created: 28 Aug 2023
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

;; Do not resize the echo area display since it is very distracting.
(setq eldoc-echo-area-use-multiline-p nil)
(setq eglot-report-progress nil)

(provide 'ce-eglot)
;;; ce-eglot.el ends here
