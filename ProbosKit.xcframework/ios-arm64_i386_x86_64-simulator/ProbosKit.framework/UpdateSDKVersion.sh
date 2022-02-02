#!/bin/sh

#  Script.sh
#  SPTProximityKit
#
#  Created by Quentin Beaudouin on 01/10/2020.
#  Copyright © 2020 Alexandre Fortoul. All rights reserved.

set -x

if [ -n "$RW_UPDATE_VERSION_IN_PROGRESS" ]; then
exit 0
fi
export RW_UPDATE_VERSION_IN_PROGRESS=1

###### Get version from git tag ###########
export GIT_VERSION=`git describe --always --tags`

###### Path to the SPTVersion.h file ###########
export VERSION_HEADER_FILE=$SRCROOT/ProbosKit/PBSVersion.h

###### Remove previous SPTVersion.h file ###########
export rm -rf $VERSION_HEADER_FILE

###### Create new SPTVersion.h file ###########
export cat > $VERSION_HEADER_FILE

echo "GIT_VERSION=@\"$GIT_VERSION\""

cat > $VERSION_HEADER_FILE <<EOF
//
// PBSVersion.h
//
// FIlE RE-CREATED AUTOMATICALLY ON EACH BUILD
// Nothing written here will be saved
//

#ifndef GIT_VERSION
#define GIT_VERSION @"$GIT_VERSION"
#endif
EOF

###### Create .last_build_git_version file ###########
echo "GIT_VERSION=$GIT_VERSION" > "$SRCROOT/.last_build_git_version"
