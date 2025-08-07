(define-module (config systems base))

(use-modules (config systems channels))
(use-modules (gnu) (gnu services desktop) (gnu services guix) (gnu services xorg) (gnu system nss))
(use-modules (guix) (guix packages))
(use-modules (nongnu system linux-initrd))

(use-package-modules ssh)
(use-service-modules networking ssh)

(define %user-name "user")

(define %guix-base-packages
  (append %base-packages
    (list
      "i3-wm"
      "i3status"
      "dmenu"
      "st"
      "nss-certs")))

(define %guix-base-services
  (append %desktop-services
    (list
      (service tor-service-type)
      (set-xorg-configuration (xorg-configuration (keyboard-layout keyboard-layout))))))

(define %guix-base
  (operating-system
    (locale "en_US.utf8")
    (timezone "Etc/UTC")
    (keyboard-layout (keyboard-layout "us"))
    (host-name "host")
    (users (cons* (user-account
                   (name %user-name)
                   (comment %user-name)
                   (group %user-name)
                   (home-directory (string-append "/home/" %user-name))
                   (supplementary-groups '("wheel" "netdev" "audio" "video")))
            %base-user-accounts))
    (packages %guix-base-packages)
    (services %guix-base-services)
    (initrd microcode-initrd)))

(display "Base module exp21\n")

%guix-base
(display "Base module exp13\n")

(export %user-name)
(export %guix-base-packages)
(export %guix-base-services)
(export %guix-base)

(display "Base module exp14\n")
