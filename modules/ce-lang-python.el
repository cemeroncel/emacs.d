;;; ce-lang-python.el --- Python Configuration -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Cem Eröncel

;; Author: Cem Eröncel
;; Created: 21 Aug 2023
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

;; Use the `ipython3' shell in the `sci' environment
(defvar ce/python-shell-interpreter-path "~/mambaforge/envs/sci/bin/ipython3"
  "Path to the default `python-shell-interpreter'.")

(defvar ce/default-conda-environment "base"
  "Name of the conda environment that will be activated at startup.")

(when (string-equal (system-name) "tuxedus")
  (setq ce/default-conda-environment "sci"))

(customize-set-variable 'python-shell-interpreter
                        (expand-file-name ce/python-shell-interpreter-path))
(customize-set-variable 'python-shell-interpreter-args "--simple-prompt")

;; Do not try to guess indentation
(customize-set-variable 'python-indent-guess-indent-offset nil)
(customize-set-variable 'python-indent-offset 4)

;; Eglot configuration
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(python-mode . ,(eglot-alternatives
                                 '(("pylsp")
                                   ("pyright-langserver" "--stdio")))
                             )))
(setq-default eglot-workspace-configuration
              '(:pylsp (:plugins (:jedi_completion (:include_params t
                                                    :fuzzy t)
                                                   :pylint (:enabled :json-false)))))

;; Use conda.el for easier configuration of Python environment variables
(use-package conda
  :ensure t
  :config
  ;; if you want interactive shell support, include:
  (conda-env-initialize-interactive-shells)
  ;; if you want eshell support, include:
  (conda-env-initialize-eshell)
  ;; Activate the default environment right away
  (conda-env-activate ce/default-conda-environment)
  )

;; To insert numpydoc style docstrings
(use-package numpydoc
  :ensure t
  :bind (:map python-mode-map
              ("C-c C-n" . numpydoc-generate))
  :custom
  (numpydoc-insert-examples-block nil)
  )

(provide 'ce-lang-python)
;;; ce-lang-python.el ends here
