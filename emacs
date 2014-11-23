(require 'package)

; Checks if `packages` are installed. If not, it will go get them
; http://stackoverflow.com/a/10095853
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
  Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))


(push '("marmalade" . "http://marmalade-repo.org/packages/")
      package-archives)
(push '("melpa" . "http://melpa.milkbox.net/packages/")
      package-archives)
(push '("~/.emacs.d/themes") load-path)

(defun load-init-after-save ()
  "After saving this file, load it"
  (if (eq 'current-buffer "~/.emacs") ('eval-buffer) (nil))
)
;; (add-hook 'after-save-hook 'load-init-after-save)

(package-initialize)

(ensure-package-installed
  'evil 'evil-surround 'key-chord 'projectile 'zenburn 'color-theme 'haskell-mode
  'evil-jumper 'evil-visualstar 'magit)

(setq evil-want-C-u-scroll t)

; Stop making dumb backups all over the place
(setq make-backup-files nil)

; Couple of nice things
(linum-mode 1)
(show-paren-mode 1)

; PURE EVIL!!!!
(require 'evil)
(require 'key-chord)
(require 'evil-surround)
(require 'evil-jumper)
(require 'evil-visualstar)
(evil-mode 1)

(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state)
(define-key evil-normal-state-map (kbd "SPC b") 'buffer-menu)
(define-key evil-normal-state-map (kbd "-") 'dired-jump)
(define-key dired-mode-map (kbd "-") 'dired-up-directory)

(key-chord-mode 1)

(global-evil-surround-mode 1)

(require 'projectile)
(projectile-global-mode t)

(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)

(require 'zenburn)
(zenburn)

(require 'haskell-mode)
(evil-define-key 'normal haskell-mode-map (kbd "M-t") 'haskell-process-do-type)
(evil-define-key 'normal haskell-mode-map (kbd "M-i") 'haskell-process-do-info)

;; Customs!

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-type (quote cabal-repl))
 '(initial-buffer-choice "~/"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
