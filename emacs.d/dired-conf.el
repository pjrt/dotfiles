(require 'evil)
(require 'dired)

(define-key evil-normal-state-map (kbd "-") 'dired-jump)
(evil-define-key 'normal dired-mode-map
  "n" 'evil-search-next
  "-" 'dired-up-directory
  "c" 'find-file
)
