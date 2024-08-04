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

