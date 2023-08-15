;;; ce-theming-modus.el --- Modus Themes configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Cem Eröncel

;; Author: Cem Eröncel
;; Created:  2 May 2023
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

;; This file configures the `modus-themes' from Protesilaos Stavrou.
;; Main themes are `modus-operandi' which is a light theme, and
;; `modus-vivendi' which is a dark theme. They have also tinted
;; version with the names `modus-operandi-tinted' and
;; `modus-vivendi-tinted'. 

;;; Code

;; The `modus-themes' are built-in in Emacs 29. We will use this
;; version for now.

;; Add all the customizations prior to loading the themes

;; Use bold for code syntax highlighting and related
(setq modus-themes-bold-constructs t)

;; Use italics for code syntax highlighting and related
(setq modus-themes-italic-constructs t)

;; Style of Org code blocks
(setq modus-themes-org-blocks 'tinted-background)

;; Heading styles
(setq modus-themes-headings
      '((0 . (bold 1.5))
        (1 . (bold 1.2))
        (2 . (bold 1.0))
        (agenda-date . (1.3))
        (agenda-structure . (variable-pitch light 1.8))
        (t . (1.0))))

;; Variable pitch in UI elements
(setq modus-themes-variable-pitch-ui t)

;; Define the themes that will be toggled
(setq modus-themes-to-toggle '(modus-operandi modus-vivendi-tinted))

;; Disable all other themes to avoid awkward blending
(mapc #'disable-theme custom-enabled-themes)

;; Load the theme of our choice
;; (load-theme 'modus-operandi t)
(load-theme 'modus-operandi t)

;; In order to easily switch between the light and dark themes
(define-key global-map (kbd "<f5>") #'modus-themes-toggle)

(provide 'ce-theming-modus)
;;; ce-theming-modus.el ends here

