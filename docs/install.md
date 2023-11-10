# Instructions for installing and running the tools in this repository.

## Requirements

- [Bazel](https://bazel.build/)
- [Jsonnet](https://jsonnet.org)

We have instructions for Debian-based Linux distributions and recommend using
[DebianTesting](https://wiki.debian.org/DebianTesting).

It is possible to work on this repository using other operating systems such as
Windows or other Linux distributions. However, we do not currently have
instructions.

## Linux Debian

On Debian-based Linux systems:

Install Bazel and Jsonnet.

```shell
sudo apt-get install bazel jsonnet
sudo apt-get install python3-absl
```

```shell
bazel build --define jsonnet_port=cpp //...
```

If that doesn't work, you might need to specify the Java JDK path. This example
is using bash:

```shell
PATH=/usr/lib/jvm/java-11-openjdk-amd64/bin:$PATH bazel build --define jsonnet_port=cpp //...
```

Finding the results:

```shell
ls bazel-bin/catalog/
```

Running the unittests:

```shell
bazel test --define jsonnet_port=cpp //...
```

Running the Earth Engine Catalog Checker:

```shell
bazel-bin/checker/ee_stac_check
```

## MacOSX using Homebrew

This requires a recent version of XCode (e.g. 14.1).

Install Homebrew from here: https://brew.sh/

Setup the environment and run the checker as follows:

```shell
brew install jsonnet
brew install bazelisk

# Install bazel
bazelisk

type -a bazel
bazel is /usr/local/brew/bin/bazel

bazel --version
# bazel 5.3.2

# You will want to checkout your own fork
git clone https://github.com/google/earthengine-catalog.git

# Mac OSX comes with a python that is too old.
brew install python3
pip3 install absl-py

bazel test //...

bazel build //checker:ee_stac_check
bazel-bin/checker/ee_stac_check
```
