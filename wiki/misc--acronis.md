# Acronis


## Acronis True Image Bootable Rescue Disc

### Computer freezes and will not boot into Acronis GUI, What should I do?

Boot the computer from Acronis True Image bootable rescue disc (Full version);  - Hit F11 key when the you get to the selection screen;  - After you get the "Linux Kernel Settings" prompt, please add "ds=off" parameter (without quotes) to the end of the Linux kernel command line

```bash
quiet ds=off

```
- Click OK

- or -

- Boot the computer from Acronis True Image bootable rescue disc (Full
version);
- Hit F11 key after the "Starting Acronis Loader..." message appears and you
get to the selection screen of the program;
- After you get the "Linux Kernel Settings" prompt, please add "acpi=off
noapic" parameter (without quotes) to the end of the Linux kernel command
line

```bash
quiet acpi=off noapic

```
- Click OK button.

