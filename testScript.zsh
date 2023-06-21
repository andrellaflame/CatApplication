#!/bin/zsh

# Util
alias PlistBuddy=/usr/libexec/PlistBuddy
INFO_PLIST_PATH=CatApplication/CatApplication/GoogleService-Info.plist

# Parameter check
API_PARAM=$1
if [ "${API_PARAM}" = 'CATS' ] || [ "${API_PARAM}" = 'DOGS' ]; then
    echo Parameter value is valid
else
    echo Wrong parameter value "${API_PARAM}"
    exit 1
fi 

# Add parameter to .plist
# PlistBuddy -c "Print" $INFO_PLIST_PATH
PlistBuddy -c "Delete ':API request value' ${API_PARAM}" $INFO_PLIST_PATH
PlistBuddy -c "Add ':API request value' string ${API_PARAM}" $INFO_PLIST_PATH


# Local variables
WORKSPACE=CatAppWorkspace.xcworkspace
SCHEME="CatApplication"
CONFIG=Release
DEST="generic/platform=iOS"

# Clean build folder
# xcodebuild -list
xcodebuild clean -workspace "${WORKSPACE}" -scheme "${SCHEME}" -configuration "${CONFIG}"

# Archivate project
VERSION="v1.0.0"
ARCHIVE_PATH="./ARCHIVES/${VERSION}.xcarchive"
xcodebuild archive -archivePath "${ARCHIVE_PATH}" -workspace "${WORKSPACE}" -scheme "${SCHEME}" -configuration "${CONFIG}" -destination "${DEST}"

# Export archive
# Create directory for export
if [ "${API_PARAM}" = 'CATS' ]; then
    EXPORT_PATH="./Exported_CATS"
else
    EXPORT_PATH="./Exported_DOGS"
fi 

if [[ -d "$EXPORT_PATH" ]]; then
    rm -r "$EXPORT_PATH"  
fi

mkdir "$EXPORT_PATH"

EXPORT_OPTIONS_PLIST="./exportOptions.plist"
xcodebuild -exportArchive -archivePath "${ARCHIVE_PATH}" -exportPath "${EXPORT_PATH}" -exportOptionsPlist "${EXPORT_OPTIONS_PLIST}"

exit 0