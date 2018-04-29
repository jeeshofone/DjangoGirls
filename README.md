[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)
[![Known Vulnerabilities](https://snyk.io/test/github/ductape/djangogirls/badge.svg?targetFile=requirements.txt)](https://snyk.io/test/github/ductape/djangogirls?targetFile=requirements.txt)
[![Maintainability](https://api.codeclimate.com/v1/badges/075d0d98c43a66850404/maintainability)](https://codeclimate.com/github/ductape/DjangoGirls/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/075d0d98c43a66850404/test_coverage)](https://codeclimate.com/github/ductape/DjangoGirls/test_coverage)

# DjangoGirls Tutorial

This is a version of the DjangoGirls tutorial (<https://tutorial.djangogirls.org/en/>).
>This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License. To view a copy of this license, visit <https://creativecommons.org/licenses/by-sa/4.0/>

## Using Windows 10 Host and Ubuntu Xenial64 in VirtualBox with Vagrant

After installing VirtualBox, add VirtualBox to the Windows path. One way to do this is to launch PowerShell as administrator and then run this command:

```sh
[Environment]::SetEnvironmentVariable("Path", "C:/Program Files/Oracle/VirtualBox;" + $env:Path, "Machine")
```

After installing Vagrant make sure to install the Vagrant VirtualBox Guest manager:

```sh
vagrant plugin install vagrant-vbguest
```

### Using the Vagrant private key

Vagrant generates a private key that can be used to authenticate an SSH session to the box. The default format of the private key is not compatible with the Windows PuTTY key format. A reference to generate theh PuTTY key is at: [https://devops.profitbricks.com/tutorials/use-ssh-keys-with-putty-on-windows/](https://devops.profitbricks.com/tutorials/use-ssh-keys-with-putty-on-windows/)

A summary of the tutorial is:
1. Install Putty [https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
2. Click `Conversions` from the PuTTY Key Generator menu and select `Import key`.
3. Navigate to the OpenSSH private key and click `Open`. The private key is at `.vagrant\machines\default\virtualbox\id_rsa`.
4. Under `Actions` / `Save the generated key`, select `Save private key`.
5. Choose an *optional* passphrase to protect the private key.
6. Save the private key to the desktop as `id_rsa.ppk`.

## Editing dependencies

The dependencies are stored in `requirements.txt`. This project uses [hashin](https://pypi.python.org/pypi/hashin) to make dependency managment more secure and still simple to use.

To add a new package to the dependencies (or update one) use:

```sh
hashin "<package-name>==<version-number>" --algorithm=sha512 --verbose --python-version $(python3 --version | cut -d' ' -f2 | cut -d'.' -f1-2)
```

After the dependency is found and added to the requirements, *verify the hash is correct before installing or commiting the requirements change!*

Then to install the dependencies use:

```sh
pip install --require-hashes -r requirements.txt
```
