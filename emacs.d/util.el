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
         package))
   )
   packages))

(defun my-load-user-init-file-after-save ()
  (when (string= (file-truename user-init-file)
                 (file-truename (buffer-file-name)))
    (let ((debug-on-error t))
      (load (buffer-file-name)))))
