# Packer - Golang Vagrant box

A packer project that creates a Vagrant box with Golang and some basic tools installed, based off another Vagrant box.

## Prerequisites

* Install [packer](https://www.packer.io/downloads.html) version `~> 1.7`.
* Install [vagrant](https://www.vagrantup.com/downloads.html).
* Ruby version `~> 3.0.2` for running KitchenCI test.

## Building the box with Packer

The packer template is in `template.pkr.hcl` file. 
For  compatibility with older packer version there are also some `JSON` templates available e.g. `template.v1.6.json`. Use the appropriate template for the version of packer you have installed.

In the `variables` section you can set parameters to customize the build. Help on setting, overriding variables in packer can be found [here](https://www.packer.io/docs/templates/user-variables.html#setting-variables).

* `base_box`  - the base box to use. It needs to be a box published to Vagrant cloud so named `user/box`
* `golang_file` - the Golang file name to download and install e.g. `go1.12.9.linux-amd64.tar.gz`.
* `skip_add` - weather to skip adding the base box to vagrant. If the box is not already added packer will fail.

Run `packer validate template.pkr.hcl` - to make basic template validation.

Run `packer build template.pkr.hcl` - to build the Vagrant box with packer.

## Testing with KitchenCI

The project includes a KitchenCI configuration to run basic tests against the box outputted from packer.

To run it you need to install the gems from the `Gemfile`. Its recommended to use ruby [`bundler`](https://bundler.io/).

Installing gems with bundler:

* `gem install bundler`
* `bundle install`

Running Kitchen tests:

* `bundle exec kitchen converge` - will build the test environment.
* `bundle exec kitchen verify` - will run the tests.
* `bundle exec kitchen destroy` - will destroy the test environment.
* `bundle exec kitchen test` - will perform the above steps with a single command.

**Caveat** - Kitchen will not remove the box from vagrant after running `kitchen destroy`. For the moment need to clean up manually by running `vagrant box remove ubuntu-golang-virtualbox-test`

## Uploading to Vagrant cloud

The project includes a script `scripts/vagrant_cloud_upload.sh` to upload the box to Vagrant cloud. It is basically a wrapper for the `vagrant cloud publish` [command](https://www.vagrantup.com/docs/cli/cloud.html#cloud-publish) so you can use it instead.

You need to set up Vagrant cloud access by setting the `VAGRANT_CLOUD_TOKEN` environment variable to your user token.

script usage: `scripts/vagrant_cloud_upload.sh [box_version]`, box_version will default to `yy.mm.dd` if not set.

## Example

```bash
packer validate template.json # basic template validation

packer build -var 'golang_file=go1.15.2.linux-amd64.tar.gz' template.v1.6json   # build the box with packer, setting the golang_ver variable.

bundle exec kitchen test # run tests

scripts/vagrant_cloud_upload.sh 1.15.2 # upload to Vagrant cloud
```
