# Rebol 2 dockerized for MacOS #

Here is the latest public version of Rebol 2 to use with Docker. This flow was created primarily to use Rebol with the latest MacOS versions (Catalina+, 64-bit), but might as well work on other host systems with minor adjustments.

## Usage ##

### Step 1: Install Docker, XQuartz and socat ###
Easiest way is to use [Homebrew](https://brew.sh/):

`$ brew update`

`$ brew cask install docker`

`$ brew cask install xquartz`

`$ brew install socat`

### Step 2: Edit `~/.zshrc` file and add to it the following code ###
Starting with macOS Catalina, Macs will now use Zsh as the default login shell and interactive shell across the operating system. That is why we need to create and/or edit `.zshrc` instead of `.bashrc`.

```
export DISPLAY_MAC=`ifconfig en0 | grep "inet " | cut -d " " -f2`:0

function startx() {
	if [ -z "$(ps -ef|grep XQuartz|grep -v grep)" ] ; then
	    open -a XQuartz
        socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
	fi
}

function rebol2() {
	docker run --rm -ti -v $(pwd):/root/host -v /tmp:/tmp -e DISPLAY=$DISPLAY_MAC rebol2 $1 $2 $3 $4 $5 $6 $7 $8 $9
}
```
Don't forget to restart the terminal afterwards or source it.

### Step 3: Build Docker image ###

`$ docker build https://github.com/vazub/rebol2-docker.git -t rebol2`

### Step 4: Run XQuartz and socat ###
`$ startx`

### Step 5: Start Rebol console ###
`$ rebol2`

### OR run Rebol scripts directly ###

`$ rebol2 <path-to-rebol-source-file>`

## Running/compiling Red from sources ##
This image can be used to run [Red programming language](https://github.com/red/red) scripts or even to compile the language executables themselves from sources.

Clone the Red repo to your machine, go to the repo root folder and run any of the following examples, or build your own commands in similar fashion, as needed: 

### Compile (Linux) test script ###
`$ rebol2 red.r %tests/hello.red`

### Compile (Linux) CLI console ###
`$ rebol2 red.r -r %environment/console/CLI/console.red`

### Compile (Windows) GUI console ###
`$ rebol2 red.r -r -t Windows %environment/console/GUI/gui-console.red`

## License ##
Use of this source code is governed by the MIT-like permissive [Blue Oak Model License](https://blueoakcouncil.org/license/1.0.0), an exact copy of which can be found in the relevant [LICENSE](./LICENSE.md) file of the current repository.
