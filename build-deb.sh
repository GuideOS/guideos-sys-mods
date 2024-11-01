#!/bin/bash

# Define the package name and version
PACKAGE_NAME="guideos-sys-mods"
VERSION="1.0"

# Define the dependencies
DEPENDENCIES="bash"

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
# postinst script placeholder
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
