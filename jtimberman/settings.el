;; yo emacs, ima let you finish but irblack is the best color theme of
;; all time
(color-theme-irblack)

;; Lets have readable fonts for all the times.
(set-face-attribute 'default nil :font "Menlo-14")

;; Confluence is cool, lets use it!
(require 'confluence)
(setq confluence-url "https://wiki.opscode.com/rpc/xmlrpc")
(global-set-key "\C-cc" 'confluence-get-page)
