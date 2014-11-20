(require 'package)
(package-initialize)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
      package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
      package-archives)
(add-to-list 'load-path "~/.emacs.d/themes")

(setq evil-want-C-u-scroll t)

(require 'evil)
(evil-mode 1)
(load-theme 'zenburn t)
(linum-mode)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
(key-chord-mode 1)

(require 'evil-surround)
(global-evil-surround-mode 1)

(require 'projectile)
(projectile-global-mode t)

(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)
