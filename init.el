;;; Base setup

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(require 'package)

(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))

(setq package-archive-priorities
      '(("gnu"    . 3)
        ("nongnu" . 2)
        ("melpa"  . 1)))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;;; Sensible defaults

(use-package emacs
  :init
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)

  (global-auto-revert-mode 1)
  (recentf-mode 1)
  (savehist-mode 1)
  (save-place-mode 1)

  (electric-pair-mode 1)
  (delete-selection-mode 1)

  :custom
  (inhibit-startup-screen t)

  (make-backup-files nil)
  (auto-save-default nil)
  (create-lockfiles nil)

  (indent-tabs-mode nil))

;;; UI settings

(add-to-list 'default-frame-alist '(font . "JetBrains Mono NL-11"))

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-gruvbox t))

;;; Programming stuff

(use-package display-line-numbers
  :hook
  ((prog-mode . display-line-numbers-mode)
   (text-mode . display-line-numbers-mode))
  :custom
  (display-line-numbers-grow-only t)
  (display-line-numbers-width 4))

(column-number-mode 1)

(setq major-mode-remap-alist
      '((c-mode   . c-ts-mode)
        (c++-mode . c++-ts-mode)))

(use-package eglot
  :hook
  ((c-mode      . eglot-ensure)
   (c++-mode    . eglot-ensure)
   (c-ts-mode   . eglot-ensure)
   (c++-ts-mode . eglot-ensure))
  :custom
  (eglot-ignored-server-capabilities
   '(:documentOnTypeFormattingProvider :inlayHintProvider)))

(use-package cc-mode
  :custom
  (c-default-style 'stroustrup)
  (c-basic-offset 4))

(use-package c-ts-mode
  :custom
  (c-ts-mode-indent-style 'linux)
  (c-ts-mode-indent-offset 4))

;;; Completion framework

(use-package vertico
  :ensure t
  :init
  (vertico-mode 1)
  :custom
  (vertico-cycle t))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil)
  (completion-pcm-leading-wildcard t))

(use-package corfu
  :ensure t
  :init
  (global-corfu-mode 1)
  :custom
  (corfu-auto t)
  (corfu-cycle t))

(use-package cape
  :ensure t
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-symbol))

(use-package consult
  :ensure t
  :bind
  (("C-s"   . consult-line)
   ("C-x b" . consult-buffer)))

(use-package embark
  :ensure t
  :custom
  (prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :ensure t)
