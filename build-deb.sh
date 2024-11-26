#!/bin/bash

# Define the package name and version
PACKAGE_NAME="guideos-sys-mods"
VERSION="1.3"

# Define the dependencies
DEPENDENCIES="bash, communitywallpapers, guideos-icons, guideos-sys-mods, guideos-ticket-tool, lightpad, primo-di-tutto, stat-denver-tools, white-sure-theme, wp-evilware, lolcat"

# Create the necessary directories
mkdir -p ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/DEBIAN
mkdir -p ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/usr/bin
mkdir -p ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/usr/share/doc/gos/

# Copy the main script
cp ~/guideos-sys-mods/bin/gos ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/usr/bin/gos



# Create the control file
cat > ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/DEBIAN/control << EOF
Package: $PACKAGE_NAME
Version: $VERSION
Architecture: all
Maintainer: Timo Westphal <pigroxtrmo@gmail.com>
Depends: $DEPENDENCIES
Section: utils
Priority: optional
Homepage: https://github.com/your-repo/gos
License: GPL-3
Description: A script to update system packages
 This package includes a script that can update APT, Flatpak, and Snap packages.
EOF

# Create the preinst file
cat > ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/DEBIAN/preinst << 'EOF'
#!/bin/bash
# preinst script placeholder
EOF

# Create the postinst file
cat > ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/DEBIAN/postinst << 'EOF'
#!/bin/bash
if [ -f /usr/share/icons/hicolor/symbolic/apps/guideos1-symbolic.svg ]; then
    cp /usr/share/icons/hicolor/symbolic/apps/guideos1-symbolic.svg /usr/share/icons/hicolor/scalable/apps/cinnamon-symbolic.svg
    echo "Icon copied successfully."
else
    echo "Source icon not found!"
    exit 1
fi

EOF

# Set executable permissions
chmod +x ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/usr/bin/gos
chmod +x ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/DEBIAN/preinst
chmod +x ~/guideos-sys-mods/DEBIAN-BUILD-BOX/debian/DEBIAN/postinst

# Build the package
cd ~/guideos-sys-mods/DEBIAN-BUILD-BOX/
chmod -R 755 debian
sudo chown -R root:root debian

dpkg-deb --build -Zxz debian

# Move the package to the current directory
mv debian.deb ~/guideos-sys-mods/$PACKAGE_NAME-$VERSION.deb

# Clean up the temporary files
sudo rm -rf debian
