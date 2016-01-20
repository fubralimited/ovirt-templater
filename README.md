# Templater

A collection of scripts to create and install a VM in oVirt, and then create
a template based off of that VM.

## Requirements

- Python 2
- [Python oVirt SDK 3.6](https://github.com/oVirt/ovirt-engine-sdk) `pip install ovirt-engine-sdk-python`
- [Python Paramiko](https://github.com/paramiko/paramiko) `pip install paramiko`
- [PyYAML](http://pyyaml.org) `pip install pyyaml`

The oVirt SDK **must** be version **3.6.x**, the 4.0 release line contains
changes which break this script.  At the time of writing, PyPI still contains
the [working version](https://pypi.python.org/pypi/ovirt-engine-sdk-python/3.6.0.3).
In case that goes away or updates to the 4.0 line, the old release should
always be available on the [oVirt resources server](http://plain.resources.ovirt.org/pub/ovirt-3.6/src/ovirt-engine-sdk-python/ovirt-engine-sdk-python-3.6.0.3.tar.gz).

## Configuration

Distros to be templated are configured in the `config.yaml` file. Each distro
is an item in the list containing entries for the name, MAC address and IP
address used for the template VM. The MAC address is used for network booting
and the IP address will be used to connect to and sysprep the VM.

## Sysprep

All files in the `files/distro/` directory will be copied to the VM at
`/tmp/sysprep/`. A script in that directory **must** be called `sysprep` as
that is executed on the VM after copying the files.

## Install

```bash
$ git clone https://github.com/fubralimited/ovirt-templater.git
```

## Usage

```bash
./make-templates --help
./make-templates -u admin@internal -r engine.example.com -v
```
