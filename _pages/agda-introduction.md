---
title: "Introduction to Agda"
permalink: /agda-intro/
modified: 2023-03-10
---

# Guide to the installation of Agda

This document presents a set of steps which should enable the installation of Agda in a Windows or Linux system. If you installed Agda months ago using this steps, then there is also a guide on how to update Agda to the latest released version. Take into account that if you have already installed some software by other means (chocolately, ghc, cabal or agda), trying this method before a clean removal of the previously installed software could generate an unknown output. Use this guide responsibly, and feel free to contact me if you find any problem!

## 1. Check if you have Agda installed

Open a terminal (in Windows open Powershell, and in Linux any terminal emulator), and type the following command:
```shell
agda
```
If you have Agda installed, you will see something similar to this output:

![Agda command output](https://user-images.githubusercontent.com/63608428/224405548-a4e77105-8774-4a20-b437-b70d990584cd.png)

In addition, you should see your installed Agda version written at the beginning of the output, in the above image, it is version 2.6.2.2.
If the command gives an error, then you don't have Agda installed, and you should follow to the installation guide in step 2.
If your version is smaller to the latest version (at the time of this writing 2.6.3), you should update your Agda installation, following the guide in step 3.

## 2. If you don't have Agda: Installation guide

### Windows

 1. Open PowerShell as Administrator and run the following command:
```shell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) ; choco install cabal ghc
```
 3. Close Powershell
 1. Open PowerShell as Administrator and run the following command:
```shell
cabal update ; cabal install alex happy Agda
```

### Linux

 1. Install [GHCUp](https://www.haskell.org/ghcup) in your Linux distribution, following the steps from the official guide. Maybe the PATH environment variable needs to be updated. 
 2. Run the following commands in a terminal:
```shell
ghcup install Agda
```

## 3. If you have Agda installed but with an old version: Upgrade guide

### Windows

 1. Open PowerShell as Administrator
 2. Run the following command:
```shell
cabal update ; cabal install alex happy Agda --upgrade-dependencies --force-reinstalls --overwrite-policy=always
```

### Linux

 1. Run the following commands in a terminal:
```shell
ghcup upgrade
ghcup install Agda
```
  
## 4. Install your editor of choice

There are mainly two editors where Agda can be used comfortably: VSCode and Emacs. VSCode is a modern and popular editor from Microsoft, which has an extension enabling the interface with Agda. Emacs is a old and complicated editor from GNU, and it is the official editor for Agda. In terms of Agda use, Emacs has a more stable and complete support, but VSCode interface is modern and accessible. Personally, I would recommend VSCode. The following sections explain how to install the editor and activate the Agda integration:

### VSCode

 1. Install [VSCode](https://code.visualstudio.com)
 2. Install two extensions: [agda-mode](https://marketplace.visualstudio.com/items?itemName=banacorn.agda-mode) and [language-agda](https://marketplace.visualstudio.com/items?itemName=j-mueller.agda).

<!-- ### VSCode (with ALS)

```
ghcup install stack
git clone https://github.com/banacorn/agda-language-server.git
cd agda-language-server && stack install && cd ..
```
TODO -->

### Emacs

 1. Install [Emacs]([https://code.visualstudio.com](https://www.gnu.org/software/emacs/))
 2. Open a terminal (in Windows open Powershell, and in Linux any terminal emulator), and run the following command:
```shell
agda-mode setup
```

## 5. Try to compile a minimal example of Agda code

<!-- TODO

```agda

``` -->

 - [Examples](https://dvmcarpena.com/files/agda-examples.zip)

<!-- ## FAQ

TODO -->
