;;; ce-theming-ef.el --- Ef Themes configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Cem Eröncel

;; Author: Cem Eröncel
;; Created:  6 May 2023
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
(defvar ce/ef-theme-choices '(ef-maris-light ef-maris-dark)
  "Theme choices for the `ef-themes'.

This is a list with two elements where the first element refers
to the light theme, and the second element refers to the dark
theme.
")

(defvar ce/default-dark-theme nil
  "Whether to start with a dark theme by default.")


(use-package ef-themes
  :ensure t
  :bind ("<f5>" . ef-themes-toggle)
  :init
  ;; The themes to toggle between them
  (setq ef-themes-to-toggle ce/ef-theme-choices)

  ;; Headings
  (setq ef-themes-headings
        '((0 . (variable-pitch 1.5))
          (1 . (variable-pitch 1.3))
          (2 . (variable-pitch 1.1))
          (t . (variable-pitch 1.0))))

  ;; Variable fonts
  (setq ef-themes-mixed-fonts t
        ef-themes-variable-pitch-ui t)

  ;; Disable all other themes to avoid awkward blending
  (mapc #'disable-theme custom-enabled-themes)

  ;; Load the theme of choice
  ;; (load-theme 'ef-winter :no-confirm)

  ;; OR use this to load the theme which also calls
  ;; `ef-themes-post-load-hook':
  (if ce/default-dark-theme
      (ef-themes-select (car (cdr ce/ef-theme-choices)))
    (ef-themes-select (car ce/ef-theme-choices)))
  )

(provide 'ce-theming-ef)
;;; ce-theming-ef.el ends here
