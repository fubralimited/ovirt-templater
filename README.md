# Templater

A collection of scripts to create and install a VM in oVirt, and then create
a template based off of that VM.

## Requirements

- Python 2
- [Python oVirt SDK](https://github.com/oVirt/ovirt-engine-sdk) `pip install ovirt-engine-sdk-python`
- [Python Paramiko](https://github.com/paramiko/paramiko) `pip install paramiko`
- [PyYAML](http://pyyaml.org) `pip install pyyaml`

## Configuration

Distros to be templated are configured in the `config.yaml` file. Each distro
is an item in the list containing entries for the name, MAC address and IP
address used for the template VM. The MAC address is used for network booting
and the IP address will be used to connect to and sysprep the VM.

## Install

```bash
$ git clone https://github.com/fubralimited/ovirt-stuff.git
```

## Usage

```bash
./make-templates --help
./make-templates -u admin@internal -r engine.example.com -v
```
