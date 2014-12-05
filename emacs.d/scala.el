(require 'evil)
(require 'scala-mode2)
(evil-define-key 'normal scala-mode-map
  ",ff" 'first-error
  ",n" 'next-error
  ",b" 'previous-error
)

