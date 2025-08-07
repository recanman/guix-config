(define-module (config systems laptop)
  (use-modules (gnu))
  (use-modules (config systems base) (config systems channels)))

(define %laptop
  (operating-system
    (inherit %guix-base)

    (bootloader
      (bootloader-configuration
        (bootloader grub-bootloader)
        (targets (list "/dev/sda"))
        (keyboard-layout keyboard-layout)))

    (mapped-devices
      (list
        (mapped-device
          (source (uuid "fbd1839c-2b68-4604-a9ab-8a5e2c63dd44"))
          (target "cryptroot")
          (type luks-device-mapping))))

    (file-systems
      (cons*
        (file-system
          (mount-point "/")
          (device "/dev/mapper/cryptroot")
          (type "ext4")
          (dependencies mapped-devices))
        %base-file-systems))

    ; (services
    ;   (cons*
    ;     (service guix-home-service-type
    ;       `((,%user-name ,%guix-home)))))

    ))

%laptop
