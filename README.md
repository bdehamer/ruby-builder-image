# ruby-builder

This is a docker recipe to build a Ruby 2.1 debian package.

## Why?

Compiling Ruby from source and building a debian package can be a bit of pain.
Encapsulating the steps in a Dockerfile gives me a repeatable way to build
the package without gumming-up my system with all of the build dependencies.
Plus, this approach allows me to use the compute resources of the Docker Hub to
the compilation work.

## How do I use it?

To get your hands on the completed debian package, just do this:

    docker run -v /tmp:/target bdehamer/ruby-builder

The `bdehamer/ruby-builder` contianer will detect the `/target` mount
point and copy the Ruby debian package into it.

## What do I do with the debian package?

Install it:

    dpkg -i ruby-2.1.2p95_amd64.deb
