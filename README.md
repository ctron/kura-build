# Eclipse Kura Build [![DockerHub](https://img.shields.io/docker/build/ctron/kura-build.svg)](https://hub.docker.com/r/ctron/kura-build/) 

This projects helps building [Eclipse Kura](https://eclipse.org/kura) images. It will
download the sources and allow to run the build in a container which has the all the
necessary dependencies installed. 

## Running with Docker

The main purpose of this project is to make is easy to build Kura images without
the need to set up a complete system for building. Everything you need is contained
in the container.

To build all images simply execute:

    docker run -ti ctron/kura-build

You can also switch the repository and branch (e.g. use `ctron/kura` on GitHub and
branch `preview(intel_up2_1`):

    docker run -ti ctron/kura-build -r ctron/kura -b preview/intel_up2_1

It is also possible to pass in arguments to the Maven build (e.g pass `-Pintel-up2-centos-7`
to the Maven build):

    docker run -ti ctron/kura-build -r ctron/kura -b preview/intel_up2_1 -- -Pintel-up2-centos-7

For a full list of arguments see section [Arguments](#arguments) below.

## Build you own container

This build container is available from Docker Hub. But you can also build
your own version of the builder container by executing:

    docker build -t kura-build https://github.com/ctron/kura-build

Or by building a local git clone:

    git clone https://github.com/ctron/kura-build
    docker build -t kura-build kura-build

## Running native

Although the biggest benefit is this project is the container, it still is
possible to run the script on a local Linux system.

For this you can simply run the script like any other shell script. e.g.:

    ./root/build-kura release-3.2.0

## Things to know

A few things you should know.

### Release builds failing

Release builds of Kura may be failing due to the usage of the "exists-maven-plugin".
For some releases you cannot use the builder as there is no automatic workaround.
You need to manually patch the POM files. For others there exists a workaround using
Maven profiles (see: <https://github.com/eclipse/kura#exists-plugin-failure>).

### Fresh local maven repository

The builder will always force a new local Maven repository when building Kura. This
will make the build run longer, but ensures that only newly compiled artifacts are
being used and nothing is mixed up with previous builds. This feature is mostly relevant
for local (non-container) builds, as a container will always have an empty local Maven
repository.

### Arguments

The builder supports the following arguments:

* `-r <repo>` – Use GitHub repository this user. Defaults to `eclipse/kura`.
  
  Using `-r ctron/kura` will clone the git repository `https://github.com/ctron/kura`.

* `-g <repo-url>` – Use the URL as GitHub repository.
  
  Using `-g https://yourgit.com:1234/kura.git` will exactly use `https://yourgit.com:1234/kura.git`
  when cloning the repository. 

* `-b <branch>` – The branch to use. Defaults to `develop`.

* `--` – Will end the argument parsing for the builder and pass all remaining arguments to the maven build.
  
  Calling the builder with `-r ctron/kura -- -Pintel-up2-centos-7` will use the GitHub repository `ctron/kura` and pass
  `-Pintel-up2-centos-7` to the maven build.
