# Docker Sharelatex-full

[![](https://images.microbadger.com/badges/image/t4skforce/sharelatex-full.svg)](https://microbadger.com/images/t4skforce/sharelatex-full "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/t4skforce/sharelatex-full.svg)](https://microbadger.com/images/t4skforce/sharelatex-full "Get your own version badge on microbadger.com")

ShareLatex with all Latex packages installed by default.


## What is

This is an extension of the [official sharelatex](https://hub.docker.com/r/sharelatex/sharelatex/).

The [texlive-full](https://packages.ubuntu.com/xenial/texlive-full) package and [tlmgr](https://www.tug.org/texlive/tlmgr.html) [full scheme](https://tex.stackexchange.com/questions/234749/downloading-every-package-with-tex-live) are installed on top of Sharelatex.

The is to create an image with many Latex packages as possible, so you do not have (hopefully) to worry about missing packages. The downside is the large size of the image.

## How to build

TeX Live repositories are pretty slow, you can [clone it locally](https://www.tug.org/texlive/acquire-mirror.html):

    wget -c --mirror --no-parent ftp://tug.org/historic/systems/texlive/2017/tlnet-final/

Or download the ISO image and extract: [ftp://tug.org/historic/systems/texlive/2019/texlive.iso](ftp://tug.org/historic/systems/texlive/2019/texlive.iso)

Then, build the image with local repository. You have to dit `Dockerfile` to use local instance of nginx:

    docker network create build_sharelatex
    docker run --network build_sharelatex --name nginx -v $PWD:/usr/share/nginx/html:ro -d nginx
    docker build --network build_sharelatex -t sharelatex-full .

### Troubleshooting

The default for the overlay config metacopy was switched from N to Y in kernel 4.19. The following should do the trick to get you going:

    echo N | sudo tee /sys/module/overlay/parameters/metacopy

## How to use

This image can be used in the same way as the official image.

Since Sharelatex requires MongoDB and Redis, it is easier to setup via [docker-compose](https://github.com/sharelatex/sharelatex/blob/master/docker-compose.yml)
(just the sharelatex image needs to be changed to [t4skforce/sharelatex-full](https://hub.docker.com/r/rigon/sharelatex-full/)):

## First login

See Overleaf wiki [Creating and managing users](https://github.com/overleaf/overleaf/wiki/Creating-and-managing-users)
