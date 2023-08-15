;;; ce-org.el --- Org-mode configuration -*- lexical-binding: t; -*-

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

;;;; Plain Org

(defun ce/org-buffer-setup ()
  "Customized setup for org-mode buffers."
  (visual-line-mode 1)
  (olivetti-mode 1)
  (mixed-pitch-mode 1)
  )

(defun ce/org-font-setup ()
  "Customized font setup for org-mode buffers."
  (set-face-attribute 'org-document-title nil
                      :weight 'extra-bold
                      :height 1.4)
  )

;; Automatically save files after org-refile
;; https://github.com/rougier/emacs-gtd/issues/9

;; Save the corresponding buffers
(defun ce/gtd-save-org-buffers ()
  "Save `org-agenda-files' buffers without user confirmation.
See also `org-save-all-org-buffers'"
  (interactive)
  (message "Saving org-agenda-files buffers...")
  (save-some-buffers t (lambda () 
			 (when (member (buffer-file-name) org-agenda-files) 
			   t)))
  (message "Saving org-agenda-files buffers... done"))

;; Add it after refile
(advice-add 'org-refile :after
	    (lambda (&rest _)
	      (ce/gtd-save-org-buffers)))

;; Make invisible parts of Org elements appear visible.
(use-package org-appear
  :ensure t
  :hook org-mode
  :custom
  (org-appear-autolinks t "Automatic toggling of links.")
  (org-appear-autosubmarkers t "Toggle subscript and superscripts.")
  (org-appear-autoentities t "Toggle Org entities.")
  (org-appear-autokeywords t "Toggle keywords in `org-hidden-keywords'")
  (org-appear-inside-latex t "Toggle entities and sub/super subscripts in LaTeX fragments.")
  )

;; Modern interface to org

(use-package org
  :hook (org-mode . ce/org-buffer-setup)
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda))
  :custom
  ;; Return or left-clock with mouse follows link
  (org-return-follows-link t)
  (org-mouse-1-follows-link t)
  ;; Show pretty entities
  (org-pretty-entities t)
  ;; Hide the emphasis markers
  (org-hide-emphasis-markers t)
  ;; Start the org modes indented
  ;; (org-startup-indented t)
  ;; Set the `org-directory'
  (org-directory "~/Documents/Org/")
  ;; Fontify quote/verse blocks
  (org-fontify-quote-and-verse-blocks t)
  ;; Highlight LaTeX fragments
  (org-highlight-latex-and-related '(native))
  ;; Interpret `_' and `^' for display
  (org-use-sub-superscripts t)
  ;; Preview of the LaTeX fragments
  (org-format-latex-options '(
                              :foreground default
                              :background default
                              :scale 1.5
                              :html-foreground "Black"
                              :html-background "Transparent"
                              :html-scale 1.0
                              :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
  ;; Record when the task is moved to the DONE state
  (org-log-done t)
  ;; TODO keywords
  (org-todo-keywords '((sequence "NEXT(n)"
                                 "TODO(t)"
                                 "ACTIVE(a)"
                                 "WAIT(w@)"
                                 "HOLD(h)"
                                 "|"
                                 "DONE(d)"
                                 "CANCELED(c@)")))
  ;; Faces for the TODO keywords
  (org-todo-keyword-faces '(("NEXT" . org-todo)
                            ("TODO" . org-todo)
                            ("ACTIVE" . org-cite)
                            ("WAIT" . org-warning)
                            ("HOLD" . org-warning)
                            ("CANCELED" . gnus-summary-cancelled)))
  ;; Capture templates
  (org-capture-templates '(("c" "Simple quick capture" entry
                            (file "~/Documents/Org/inbox-desktop.org")
                            "* %? \nEntered on %U\n %i\n")
                           ("t" "Scheduled todo" entry
                            (file+headline "~/Documents/Org/tasks.org"
                                           "Scheduled Tasks")
                            "* TODO %? \n SCHEDULE THE TASK!")
                           ("a" "Next action" entry
                            (file+headline "~/Documents/Org/tasks.org"
                                           "Single Task Actions")
                            "* NEXT %?")
                           ("p" "Project" entry
                            (file "~/Documents/Org/projects.org")
                            (file "~/.config/emacs/org-templates/project.org"))
                           ("e" "Emacs config" entry
                            (file+headline "~/Documents/Org/tasks.org"
                                           "Emacs config")
                            "* TODO %?")
                           )
                         )
  ;; Refile targets
  (org-refile-targets '(
                        ("tasks.org" :level . 1)))
  ;; Agenda files
  (org-agenda-files (list
                     (expand-file-name "tasks.org" org-directory)
                     (expand-file-name "inbox-desktop.org" org-directory)
                     (expand-file-name "projects.org" org-directory)
                     (expand-file-name "daily-tasks.org" org-directory)))
  ;; Include entries from the Emacs diary into Org mode's agenda
  (org-agenda-include-diary t)
  ;; Use tag inheritance but exclude some of the tags
  (org-use-tag-inheritance t)
  (org-tags-exclude-from-inheritance '("project"))
  ;; Get the image with from the attributes
  (org-image-actual-width nil)
  ;; Org-agenda views
  (org-agenda-custom-commands '(
                                ("d" "Daily view"
                                 (
                                  (agenda ""
                                          (
                                           (org-agenda-block-separator " ")
                                           (org-agenda-overriding-header "📅 Today's agenda\n")
                                           (org-agenda-span 1)
                                           ))
                                 )
                                 )
                                ("n" "Next action list"
                                 (
                                  (tags-todo "important/NEXT"
                                             (
                                              (org-agenda-overriding-header "🔴 Important\n")
                                              )
                                             )
                                  (tags-todo "collab/NEXT"
                                             (
                                              (org-agenda-overriding-header "🟢 Collaboration\n")
                                              )
                                             )
                                  (tags-todo "teaching/NEXT"
                                             (
                                              (org-agenda-overriding-header "🟤 Teaching\n")
                                              )
                                             )
                                  (tags-todo "admin/NEXT"
                                             (
                                              (org-agenda-overriding-header "🟣 Administrative\n")
                                              )
                                             )
                                  (tags-todo "personal/NEXT"
                                             (
                                              (org-agenda-overriding-header "🔵 Personal\n")
                                              )
                                             )
                                  ))
                                ("p" "Project list"
                                 (
                                  (tags-todo "project+important/ACTIVE"
                                             (
                                              (org-agenda-overriding-header "🔴 Active Projects: Important\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )
                                  (tags-todo "project+collab/ACTIVE"
                                             (
                                              (org-agenda-overriding-header "🟢 Active Projects: Collaboration\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )
                                  (tags-todo "project+teaching/ACTIVE"
                                             (
                                              (org-agenda-overriding-header "🟤 Active Projects: Teaching\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )
                                  (tags-todo "project+admin/ACTIVE"
                                             (
                                              (org-agenda-overriding-header "🟣 Active Projects: Administrative\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )
                                  (tags-todo "project+personal/ACTIVE"
                                             (
                                              (org-agenda-overriding-header "🔵 Active Projects: Personal\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )                                  
                                  (tags-todo "project/HOLD"
                                             (
                                              (org-agenda-overriding-header "🟡 Projects on hold\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )
                                  (tags-todo "project/WAIT"
                                             (
                                              (org-agenda-overriding-header "🟠 Projects on waiting\n")
                                              (org-agenda-remove-tags t)
                                              (org-agenda-prefix-format " ")
                                              )
                                             )
                                  ))
                                ))
  :config
  (customize-set-variable 'org-directory "~/Documents/Org/")
  ;; Babel languages
  ;; (org-babel-do-load-languages
  ;;  'org-babel-load-languages
  ;;  '((emacs-lisp . t)
  ;;    (julia . t)
  ;;    (python . t)
  ;;    (jupyter . t)))
  ;; Default parameters for the languages
  ;; (setq org-babel-default-header-args:jupyter-julia '((:async . "yes")
  ;;                                                     (:session . "jl")
  ;;                                                     (:kernel . "julia-1.8")))
  ;; Activate CDLaTeX
  (add-hook 'org-mode-hook #'turn-on-org-cdlatex)
  )

;;;; Org-pomodoro
(use-package org-pomodoro
  :after org
  :ensure t
  :commands (org-pomodoro)
  :custom
  (org-pomodoro-length 50)
  (org-pomodoro-short-break-length 10)
  (org-pomodoro-finished-sound-p t)
  :config
  ;; Add a keybinding to Org Agenda View
  ;; (add-hook 'org-agenda-mode-hook
  ;;         (lambda ()
  ;;                 (local-set-key (kbd "C-c p") 'org-pomodoro)))
  (define-key org-agenda-mode-map (kbd "C-c p") 'org-pomodoro)
  )

;;;; org-fragtog
;; Automatically toggle Org model LaTeX fragment previews as the
;; cursor enters and exists them.
;; https://github.com/io12/org-fragtog
(use-package org-fragtog
  :ensure t
  :after org
  :hook org-mode)

;;;; org-download
;; Easily insert images to Org files
;; https://github.com/abo-abo/org-download
(use-package org-download
  :ensure t
  :after org
  :custom
  (org-download-method 'directory)
  :config
  (setq-default org-download-image-dir (expand-file-name "~/Documents/denote/attachments/")))


(provide 'ce-org)
;;; ce-org.el ends here

