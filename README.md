# Templater

A collection of scripts to create and install a VM in oVirt, and then create
a template based off of that VM.

## Requirements

- Python 2
- [Python oVirt SDK](https://github.com/oVirt/ovirt-engine-sdk) `pip install ovirt-engine-sdk-python`
- [Python Paramiko](https://github.com/paramiko/paramiko) `pip install paramiko`
- [PyYAML](http://pyyaml.org) `pip install pyyaml`

## Install

```bash
$ git clone https://github.com/fubralimited/ovirt-stuff.git
```

## Usage

```bash
./make-template --help
./make-template -u admin@internal -r engine.example.com -v
```
