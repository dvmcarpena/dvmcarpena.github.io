---
title: "Introduction to Agda"
permalink: /agda-intro/
modified: 2022-09-30
---

# Introduction to Agda

## [Examples](https://dvmcarpena.com/files/agda-examples.zip)

## Agda Installation Guide

### 1. Windows

 1. Open PowerShell as Administrator
 2. Run the following command:
```shell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) ; choco install cabal ghc emacs
```

 3. Restart Powershell as Administrator
 4. Run the following command:
```shell
cabal update ; cabal install alex happy Agda ; agda-mode setup
```

 6. Install [VSCode](https://code.visualstudio.com)
 7. Install two extensions: [agda-mode](https://marketplace.visualstudio.com/items?itemName=banacorn.agda-mode) and [language-agda](https://marketplace.visualstudio.com/items?itemName=j-mueller.agda).

### 2. Linux

First, install [GHCUp](https://www.haskell.org/ghcup) in your Linux distribution, following the steps from the official guide. Maybe the PATH environment variable needs to be updated. Then, run the following commands in a terminal:

```shell
ghcup install Agda
agda-mode setup
```


<!-- ## 2. ALS (VSCode)

### 2.1. Windows

 1. Open PowerShell as Administrator
 2. Run the following command:
```shell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) ; choco install ghc
```

 6. Install [VSCode](https://code.visualstudio.com)
 7. Install two extensions: [agda-mode](https://marketplace.visualstudio.com/items?itemName=banacorn.agda-mode) and [language-agda](https://marketplace.visualstudio.com/items?itemName=j-mueller.agda).
 8. Activate the experimental lanaguage server of agda-mode.

### 2.2. Linux

First, install [GHCUp](https://www.haskell.org/ghcup) in your Linux distribution, following the steps from the official guide. Maybe the PATH environment variable needs to be updated. Then, run the following commands in a terminal:

```
ghcup install stack
git clone https://github.com/banacorn/agda-language-server.git
cd agda-language-server && stack install && cd ..
``` -->
