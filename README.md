# Templater

A collection of scripts to create and install a VM in oVirt, and then create
a template based off of that VM.

## Procedure

- A temporary VM is created with the specified name, OS type and MAC address.
- The VM is network booted and an automated install is expected to take place -
  this will require functioning network boot infrastructure and the automated
  install method for the distro to be configured (for example, a Kickstart
  script for RHEL derivatives). The VM is expected to **power off** after
  install and not reboot.
- The VM is powered on and the script waits for an SSH connection. It is
  expected that the user's SSH key is inserted into the root user of the VM
  during install.
- `sysprep` files are copied to the VM and the script is run on the VM. The
  `sysprep` script is expected to **power off** the VM when it has finished.
- The script waits for the VM to be shut down and then creates the template
  from the VM.
- The temporary VM is removed.

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

## Install

No OS packages are available yet.

```bash
$ git clone https://github.com/fubralimited/ovirt-templater.git
```

## Usage

- Rename the `config.yaml.example` file to `config.yaml` and customise as
  required. See the [#configuration](configuration) section of this README for
  details about the available options.
- Run `./make-templates --help` to view available command line options.

## Configuration

Most options can be configured on the command line but a configuration file is
also available. Distro definitions are **required** in the config file, these
cannot be passed in on the command line.

Each distro in the configuration file is an item in the list containing entries
for the name, MAC address, IP address and OS type used for the template VM. The
MAC address is set on the template VM and so can be used to configure the
network boot options on your DHCP server as well as a static IP lease. The IP
address will be used to connect to the VM once it is installed, so a static
lease in your DHCP server is a good idea.

Additional options are available in the config file to set the `host` of the
oVirt API, as well as the `username` and `password` used to connect to it.

The example configuration file shows some definitions for CentOS 6 and
7 installs.

## Sysprep

All files in the `files/distro/` directory will be copied to the VM at
`/tmp/sysprep/`. A script in that directory **must** be called `sysprep` as
that is executed on the VM after copying the files.

Example sysprep scripts are included for CentOS 6 and 7 installs. You may wish
to customise or replace these.
