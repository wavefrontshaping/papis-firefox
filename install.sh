#!/bin/bash

DEFAULT_PATH=/opt/papis-connector

echo "This will install Papis connector app and package the Firefox web extension."
while true; do
    read -r -p "Do you wish to continue? [Y/n]" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) break;;
    esac
done

echo "Where do you want to install the connector app?"
echo "(default is ${DEFAULT_PATH})"


read -p "" dir
# if no input, use default
[[ -z "${dir// }" ]] && dir=$DEFAULT_PATH
echo $dir
mkdir -p $dir


echo "Copying the connector app to $dir"
chmod +x ./app/papis_connector.py
cp ./app/papis_connector.py $dir

## Now replace the path value in the json file
echo "Editing and copying json file to mozilla local folder"
cp ./app/papis_connector.json temp.json
sed -i "s|^\(\s*"path"\s*:\s*\).*,$|\1$dir|" temp.json
mkdir -p ~/.mozilla/native-messaging-hosts
mv temp.json ~/.mozilla/native-messaging-hosts/papis_connector.json

echo "Packaging the Firefox web extension"
cd add-on
zip -r -FS ../papis-firefox.zip *

echo "Installation successful"
echo "Now install the add-on \"papis-firefox.zip\" in Firefox."
echo "This add-on is not signed! You probably need to change the parameter \"xpinstall.signatures.required preference\" to false in about:config."

read -p ""




