# Rebol with Docker

Here is the latest public version of **Rebol 2** to use with Docker. This flow was created primarily to use Rebol with the latest MacOS versions (Catalina+, 64-bit) and Windows 10+, but should work on Linux as well, with minor adjustments.

When set up correctly, you will be able to use `rebol2-docker` command as a drop-in replacement for the usual standalone **Rebol** executable in all relevant contexts.

- [Build Docker Image](#build-docker-image)
- [MacOS Setup](#macos-setup)
- [Windows 10 Setup](#windows-10-setup)
- [Usage](#usage)
- [Running or compiling Red from sources](#running-or-compiling-red-from-sources)
- [License](#license)
---
## Build Docker Image ##
```
docker build https://github.com/vazub/rebol2-docker.git -t rebol2-docker
```
## MacOS Setup ##

Install **XQuartz** and **socat**. Easiest way is to use [Homebrew](https://brew.sh/):
```
brew update && brew cask install xquartz && brew install socat
```
Starting with macOS Catalina, Macs will now use **Zsh** as the default login shell and interactive shell across the operating system. That is why we need to create and/or edit `.zshrc` instead of `.bashrc`.
```
echo $'export DISPLAY_MAC=$(ifconfig en0 | grep "inet " | cut -d " " -f2):0' >> ~/.zshrc
```
```
echo $'function startx() {\n\tif [ -z "$(ps -ef|grep XQuartz|grep -v grep)" ] ; then\n\t\topen -a XQuartz\n\t\tsocat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\\\"$DISPLAY\\\" &\n\tfi\n}' >> ~/.zshrc
```
```
echo $'function rebol2-docker() {\n\tdocker run --rm -ti -v $(pwd):/root/host -v /tmp:/tmp -e DISPLAY=$DISPLAY_MAC rebol2-docker $1 $2 $3 $4 $5 $6 $7 $8 $9\n}' >> ~/.zshrc
```
```
source ~/.zshrc
```
Start **XQuartz** and **socat**:
```
startx
```
## Windows 10 Setup ##

This setup flow depends on WSL2 and some X11 server (tested with X410) to be installed and running on the host system.

In PowerShell run `wsl` to start the default distro

If using WSL versions of distros with Bash shell, run these commands in sequence:
```
echo $'export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk \'{print $2}\'):0.0' >> ~/.bashrc
```
```
echo $'function rebol2-docker {\n\tdocker run --rm -ti -v ~:/root/host -e DISPLAY=$DISPLAY rebol2-docker $1 $2 $3 $4 $5 $6 $7 $8 $9\n}' >> ~/.bashrc
```
```
source ~/.bashrc
```
Working with other default shells should be the same, just replace output redirection in above commants to your shell's session profile.

## Usage ##
Run Rebol with the `rebol2-docker` command. This will start the REPL. Otherwise, you can use it as a drop-in replacement, to run scripts, like this:
```
rebol2-docker <your-script>.r
```
## Running or compiling Red from sources ##
This image can be used to run [Red programming language](https://github.com/red/red) scripts or even to compile the language executables themselves from sources.

Clone the Red repo to your machine, go to the repo root folder and run any of the following examples, or build your own commands in similar fashion, as needed:

### Compile (Linux) test script ###
```
rebol2-docker red.r %tests/hello.red
```
```
### Compile (Linux) CLI console ###
rebol2-docker red.r -r %environment/console/CLI/console.red
```
```
### Compile (Windows) GUI console ###
rebol2-docker red.r -r -t Windows %environment/console/GUI/gui-console.red
```
## License ##
Use of this source code is governed by the MIT-like permissive [Blue Oak Model License](https://blueoakcouncil.org/license/1.0.0), an exact copy of which can be found in the relevant [LICENSE](./LICENSE.md) file of the current repository.
