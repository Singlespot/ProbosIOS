#!/bin/sh

#  BuildXCFramework.sh
#  SPTProximityKit
#
#  Created by Quentin Beaudouin on 01/10/2020.
#  Copyright © 2020 Alexandre Fortoul. All rights reserved.

SCHEME_NAME="${PROJECT_NAME}"
FRAMEWORK_NAME="${PROJECT_NAME}"
SIMULATOR_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphonesimulator.xcarchive"
DEVICE_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphoneos.xcarchive"
FRAMEWORK_LOCATION="${BUILT_PRODUCTS_DIR}/${FRAMEWORK_NAME}.xcframework"

# Archive takes 3 params
#
# 1st == SCHEME
# 2st == sdk
# 3rd == archivePath
function archive {
    echo "▸ Starts archiving the scheme: ${1} for destination: ${2};\n▸ Archive path: ${3}.xcarchive"
    xcodebuild archive \
    -project "${PROJECT_NAME}.xcodeproj" \
    -scheme ${1} \
    -sdk ${2} \
    -configuration ${CONFIGURATION} \
    -archivePath "${3}" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES
}

# Clean build folder
xcodebuild clean -project "${PROJECT_NAME}.xcodeproj"

# Simulator xcarchieve
archive ${SCHEME_NAME} iphonesimulator ${SIMULATOR_ARCHIVE_PATH}
# Device xcarchieve
archive ${SCHEME_NAME} iphoneos ${DEVICE_ARCHIVE_PATH}

# Clean up old output directory
rm -rf "${OUTPUT_DIC}"
# Create xcframwork combine of all frameworks
xcodebuild -create-xcframework \
  -framework ${SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -framework ${DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
  -output ${FRAMEWORK_LOCATION}


DEST_FOLDER="${HOME}/Desktop"

# Test if we are in Continue Integration environement
if [ "-${BACKUP_XCARCHIVE_DESTINATION}" != "-" ]; then
    DEST_FOLDER="${BACKUP_XCARCHIVE_DESTINATION}"
fi

# Copy the framework to the user's desktop
ditto "${FRAMEWORK_LOCATION}" "${DEST_FOLDER}/${FRAMEWORK_NAME}.xcframework"

# make a zip from the framework
cd "${DEST_FOLDER}"
zip --symlinks -r "${FRAMEWORK_NAME}.zip" "${FRAMEWORK_NAME}.xcframework"
