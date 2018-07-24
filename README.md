# papis-firefox

## Description
papis-firefox is a Firefox add-on for integration with [Papis](https://github.com/papis/papis), a powerful command-line bibliography manager for Linux.
It allows to add an entry in Papis using the url of the current page.
It installs a button in the navigation bars that simply executes in a new terminal the command:
`papis add --from-url <url>`with <url> `<url>` being the url of the current tab.
  
 Due to the security restrictions on web extensions, the add-on cannot execute the command itself.
 It requires a connector app written in Python.
 The web extension sends thes url to the connector app, using *native messaging*, that executes the command.



## Installation
Simply launch the install.sh script and follow the instructions.

It will perform the following tasks:
* Copy theconnector app `papis_connector.py` in the user provided location.
* Create a `papis_connector.json` file and copy it in the `.mozilla` local folder to allow the Firefox add-on to communicate with the connector app.
* Create a .zip with the web extension to be installed on Firefox.

The add-on then needs to be installed on Firefox. 
Because the add-on is not signed, to be installed, it is required to change the parameter `xpinstall.signatures.required preference`to false in [about:config](about:config). 
**Note that this change may create a security vulnerability on your system, use it at your own risks.**
The `.zip` package can then be installed through the **Add-ons** section of the Firefox menu.
