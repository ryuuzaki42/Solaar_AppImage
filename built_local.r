# Local built
    # Github runner error when try install dbus-python

## Download python AppImage
wget https://github.com/niess/python-appimage/releases/download/python3.9/python3.9.13-cp39-cp39-manylinux2010_x86_64.AppImage

fileName=$(ls python3*.AppImage)
chmod +x "$fileName"

## install Solaar
./"$fileName" --appimage-extract
cd squashfs-root/opt/python3*/bin/

./pip3.* install Solaar

./pip3.* install typing_extensions

./python3.* -m pip install --upgrade pip

./solaar

cd ../../../../

## Download Appimagetool
version_go_appimage=$(wget -q -O - https://api.github.com/repos/probonopd/go-appimage/releases | grep "\"name.*appimagetool-.*-x86_64.AppImage\"" | head -n 1 | cut -d '-' -f2)

wget "https://github.com/probonopd/go-appimage/releases/download/continuous/appimagetool-$version_go_appimage-x86_64.AppImage" -O appimagetool-x86_64.AppImage

chmod +x appimagetool-x86_64.AppImage

## Prepare Appimage folder
version_Solaar="1.1.14"

rm -v .DirIcon AppRun

mv python.png Solaar.png
mv python*.desktop Solaar.desktop

sed -i "s/Name=.*/Name=Solaar/" Solaar.desktop
sed -i "s/Icon=python/Icon=Solaar/" Solaar.desktop
cat Solaar.desktop

cd ../
chmod 0755 squashfs-root/

## Copy configuration from repository
git clone https://github.com/ryuuzaki42/Solaar_AppImage
cp Solaar_AppImage/README.md squashfs-root/
cp Solaar_AppImage/AppRun squashfs-root/

## Make AppImage
ARCH=x86_64 VERSION="${version_Solaar}-1_JB" ./appimagetool-x86_64.AppImage squashfs-root/

fileName=$(ls Solaar*.AppImage)
md5sum "$fileName" > "${fileName}.md5"

## Test
chmod +x Solaar-1.1.14-1_JB-x86_64.AppImage
./Solaar-1.1.14-1_JB-x86_64.AppImage
kdesu ./Solaar-1.1.14-1_JB-x86_64.AppImage
