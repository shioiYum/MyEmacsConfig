;;disable some stuffs
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
		 


(require 'package)

(defmacro append-to-list (target suffix)
  "Append SUFFIX to TARGET in place."
  `(setq ,target (append ,target ,suffix)))


(append-to-list package-archives
                '(("melpa" . "http://melpa.org/packages/") 
                  ("melpa-stable" . "http://stable.melpa.org/packages/") 
                  ("org-elpa" . "https://orgmode.org/elpa/")))


(package-initialize)


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))



(require 'use-package)
(setq
 use-package-always-ensure t
 use-package-verbose t)


;;setting up theme
(use-package doom-themes
  :init
  (load-theme 'doom-one))


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)




;; Make M-x and other mini-buffers sortable, filterable
(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-height 15
        ivy-use-virtual-buffers t
        ivy-use-selectable-prompt t))

(use-package counsel
  :after ivy
  :init
  (counsel-mode 1)
  :bind (:map ivy-minibuffer-map))



;;for languages
(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    projectile hydra flycheck company avy which-key helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))



(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))


;;font size
(set-frame-font "Jetbrains mono 12" nil t)

;;Line number
(setq display-line-numbers 'relative)


;;MAGGIT

(use-package magit)
