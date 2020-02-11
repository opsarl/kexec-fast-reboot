# kexec-fast-reboot

Reboot your server in seconds, not minutes!

## Overview

I was looking for a solution to reboot our HP Proliants without having to go 
through the agonizing long BIOS startup sequence. At first, I found 
https://github.com/error10/kexec-reboot which worked great on my dev server 
but our production servers use ZFS and it was not able to parse the grub config.
I looked long and hard at various github projects but none of them were able
to parse the grub config correctly.... Until I found 
https://github.com/avagin/kexec-reboot. It uses the `grubby` utility which does 
grub and grub2 parsing "professionally" and it finally worked.

Kexec lets you boot your Linux kernel into another kernel without going through 
the hardware reset and reinitialization performed by your system BIOS or
firmware. Since this process can take several minutes, being able to skip it
reduces your downtime.

The problem with kexec is that it is an entirely manual process, requiring you 
to copy and paste the right kernel, initrd and command line arguments, and hope
you got everything right.

kexec-fast-reboot aims to automate staging a kernel for kexec, so that you can
reboot more quickly and accurately.

Result: Reboot your server in seconds, not minutes!

I forked it because it did not seem to be maintained and had a couple of pull
requests that seemed useful. Also I wanted a repo I could pull down that would
just "work" for our servers. I renamed the project to kexec-fast-reboot as I 
wanted a unique name that I could find on github. I renamed the executable 
from kreboot to fast-reboot to align with this change.

## Prerequisites

kexec-reboot requires the following packages to be installed:

 * `kexec-tools` 2.0.0 or higher, for `/sbin/kexec`
 * `grubby` from https://github.com/rhboot/grubby or you package manager
 
I am on Debian and I could not find a way to install grubby via apt. So I had to
compile it. It's very straight forward. Simply `make && make install` will do. 
I did need to install `libpopt-dev` and `libblkid-dev` so it would compile. 

I have included my compiled version of grubby in this repo, mainly for my own use, 
so I could pull it down whenever I needed it. YMMV on different systems and 
architectures of course as far as the provided `grubby` is concerend. 

In addition, the system must use grub to boot, as kexec-fast-reboot reads the grub
configuration to determine what kernels are available. Both grub 1 and 2, BIOS and
UEFI boot should work. But please test before blindly copying this onto a 
production machine.

## Install

Git clone this project, cd into it and run `make install` and it will put it all in 
the right places (it does not compile anything, its just a bash script).

Use `make uninstall` to remove it. Alternatively just copy the bash script somewhere
in your path. 

If you want to use the included `grubby` copy it somewhere in your
path. `/ust/local/bin` seems like a good choice.

## Usage


Options are:
```
Usage: fast-reboot [option ...] [kernel|boot-index]
    --wait, -w N    Wait N seconds before reboot (default 10)
    --nowait        Don't wait, reboot immediately
    --detach        Schedule reboot and return. Suitable to remote reboot.
    --help, -h      Show help message
    --kargs, k      Additional kernel arguments
```

## Examples

This is a screencast made by the original project. It uses kreboot as the command
but otherwise it's the same.

[![asciicast](https://asciinema.org/a/cjd93we16cfihfcyu03xv6mkz.png)](https://asciinema.org/a/cjd93we16cfihfcyu03xv6mkz)
