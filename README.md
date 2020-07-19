# Rebol 2 Dockerized for MacOS #

Here is the latest public version of Rebol 2 to use with Docker. This flow was created primarily to use Rebol with the latest MacOS versions (64-bit), but might as well work on other host systems.

### Step 1: Install Docker, XQuartz and socat ###
Easiest way is to use Homebrew:

`$ brew update`

`$ brew cask install docker`

`$ brew cask install xquartz`

`$ brew install socat`

### Step 2: Edit `~/.zshrc` file and add to it the following code ###

```
export DISPLAY_MAC=`ifconfig en0 | grep "inet " | cut -d " " -f2`:0

function startx() {
	if [ -z "$(ps -ef|grep XQuartz|grep -v grep)" ] ; then
	    open -a XQuartz
        socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
	fi
}

function rebol2() {
	docker run --rm -ti -v $(pwd):/root/host -v /tmp:/tmp -e DISPLAY=$DISPLAY_MAC rebol2
}
```
Don't forger to restart the terminal afterwards or source it.

### Step 3: Build Docker image ###

`$ docker build https://github.com/vazub/rebol2-docker.git -t rebol2`

### Step 4: Run Xquartz and socat ###
`$ startx`

### Step 5: Run Rebol container with arguments ###

`$ rebol2 <path-to-rebol-source-file>`

## License ##
Use of this source code is governed by the [Blue Oak Model License](https://blueoakcouncil.org/license/1.0.0), an exact copy of which can be found in the relevant [LICENSE](./LICENSE) file of the current repository.