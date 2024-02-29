#!/bin/bash

echo "Please enter your project name :"
read -r PROJECT_NAME

echo "please enter domain name :"
read -r domain

# Get the current working directory
current_directory=$(pwd)
echo "Current working directory: $current_directory"
#New project path
# shellcheck disable=SC2164
cd .. && mkdir generated_project && cd generated_project
CUSTOM_PROJECT_DIR=$(pwd)
echo "CUSTOM_PROJECT_DIR directory: $CUSTOM_PROJECT_DIR"

#Structre Project path
ORG_DIR="$current_directory/cubit_demo_project/Bit-Merge-Mobile-master"

#**************************** COMMAND TO CREATE-PROJECT ***************************************

flutter create --org com.$domain "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"
echo "-------------------------------------------------"
echo "CREATED PROJECT $CUSTOM_PROJECT_DIR/$PROJECT_NAME"
echo "-------------------------------------------------"

#**************************** COPY-FILES-TO-bit-merge-project ***************************************

cp -r "$ORG_DIR/lib" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"
cp -r "$ORG_DIR/assets" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"
cp -r "$ORG_DIR/pubspec.yaml" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"

#**************************** changes directory to project ***************************************

find "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/lib" -type f -exec sed -i "" "s/bit_merge_mobile/$PROJECT_NAME/g" {} +
sed -i "" "s/bit_merge_mobile/$PROJECT_NAME/g" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/pubspec.yaml"
sed -i "" "s/<desc>/A new flutter project./g" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/pubspec.yaml"

# Move to the newly created project directory
cd "$CUSTOM_PROJECT_DIR/$PROJECT_NAME" || exit

flutter pub upgrade

echo "Please enter your App name :"
read -r DISPLAY_NAME

#**************************** APP-RENAME ***************************************
dart run "$current_directory"/rename_app/main.dart all="$DISPLAY_NAME"

#**************************** Project add to GIT ***************************************

echo "Please enter git repository:"
read -r repository

git init
git add .
echo "Please enter the commit message :"
read -r commit_message
git commit -m "$commit_message"
git remote add origin "$repository"
git push -u origin master

#**************************** key.properties-generated ***************************************

echo "Please Enter store password (at least 6 characters):"
while true; do
  read -r storePassword
  if [ ${#storePassword} -ge 6 ]; then
    break
  else
    echo "Password must be at least 6 characters. Please try again."
  fi
done

echo "Please Enter key password (at least 6 characters):"
while true; do
  read -r key_Password
  if [ ${#key_Password} -ge 6 ]; then
    break
  else
    echo "Password must be at least 6 characters. Please try again."
  fi
done

# Validation or other checks can be added here if needed
keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload -storepass "$storePassword" -keypass "$key_Password"

# Update key.properties file with dynamic password
echo "storePassword=$storePassword" >>android/key.properties
echo "keyPassword=$key_Password" >>android/key.properties
echo "keyAlias=upload" >>android/key.properties
echo "storeFile=../app/upload-keystore.jks" >>android/key.properties

#**************************** APP-ICON-GENERATED ***************************************
dart run "$current_directory"/app-icon-generator/lib/main.dart "$current_directory"

cp -r $CUSTOM_PROJECT_DIR/"$PROJECT_NAME"/android/app/src/main/res/ "$current_directory"/app-icon-generator/android/
cp -r $CUSTOM_PROJECT_DIR/"$PROJECT_NAME"/android/app/src/main/res/ "${current_directory}"/app-icon-generator/android/
# Remove the original Android resources
rm -r "${current_directory}"/app-icon-generator/android/
cp -r $CUSTOM_PROJECT_DIR/"$PROJECT_NAME"/ios/Runner/ "${current_directory}"/app-icon-generator/ios/
# Remove the original Ios resources
rm -r "$current_directory"/app-icon-generator/ios/

echo "-------------------------------------------------"
echo "ALL DONE!!!"
echo "-------------------------------------------------"
