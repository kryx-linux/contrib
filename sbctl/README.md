Secure Boot with sbctl
======================

Oriented along [Unified Extensible Firmware Interface/Secure Boot - ArchWiki](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot)

From a system that did not yet use secure boot:

```
# sbctl status
Installed:      ✗ sbctl is not installed
Setup Mode:     ✓ Disabled
Secure Boot:    ✗ Disabled
Vendor Keys:    microsoft
```

Reboot to BIOS. Enable/execute the following steps:

- Enable Secure Boot
- Reset Secure Boot to Setup Mode

Reboot to OS. From a root shell, run:

```
# sbctl status
Installed:      ✗ sbctl is not installed
Setup Mode:     ✗ Enabled
Secure Boot:    ✗ Disabled
Vendor Keys:    microsoft
# grub-install --target=x86_64-efi --efi-directory=<your-efi-location> --bootloader-id=GRUB --modules="tpm" --disable-shim-lock
# sbctl create-keys
# sbctl enroll-keys -m ## this step might need you to run first: chattr -i /sys/firmware/efi/efivars/*
# sbctl sign -s <your-efi-location>/EFI/grub/grubx64.efi
# sbctl sign -s /boot/vmlinuz-6.9.0-rc3
# grub-mkconfig -o /boot/grub/grub.cfg
```

Reboot and confirm that your system booted correctly:

```
# sbctl status
Installed:      ✓ sbctl is installed
Owner GUID:     <some-owner-guid>
Setup Mode:     ✓ Disabled
Secure Boot:    ✓ Enabled
Vendor Keys:    microsoft
```
