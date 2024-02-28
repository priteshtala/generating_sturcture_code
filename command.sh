CUSTOM_PROJECT_DIR="/Volumes/Data/flutter"
ORG_DIR="/Volumes/Data/flutter/generating_structure_code/cubit_demo_project/Bit-Merge-Mobile-master"

echo "Please enter your project name :"
read PROJECT_NAME

##For creating and importing project.
flutter create --org com.gtp "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"
echo "-------------------------------------------------"
echo "CREATED PROJECT $CUSTOM_PROJECT_DIR/$PROJECT_NAME"
echo "-------------------------------------------------"

##Copying required directories.
cp -r "$ORG_DIR/lib" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"
cp -r "$ORG_DIR/assets" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"
cp -r "$ORG_DIR/pubspec.yaml" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"

##Changing required directories.
find "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/lib" -type f -exec sed -i "" "s/bit_merge_mobile/$PROJECT_NAME/g" {} +
sed -i "" "s/bit_merge_mobile/$PROJECT_NAME/g" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/pubspec.yaml"
sed -i "" "s/<desc>/A new flutter project./g" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/pubspec.yaml"

# Move to the newly created project directory
cd "$CUSTOM_PROJECT_DIR/$PROJECT_NAME" || exit

flutter pub upgrade

echo "Please enter your App name :"
read DISPLAY_NAME

##For changing name of app
dart run /Volumes/Data/flutter/generating_sturcture_code/rename_app/main.dart all="$DISPLAY_NAME"

echo "please enter git repository :"
read  -r repository

git init
git add .
echo "Please enter the commit message :"
read -r commit_message
git commit -m "$commit_message"
git remote add origin "$repository"
git push -u origin master

echo "Please Enter store password :"
read -r storePassword

echo "Please Enter key password :"
read -r  key_Password

# Validation or other checks can be added here if needed
keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload -storepass "$storePassword" -keypass "$key_Password"

# Update key.properties file with dynamic password
echo "storePassword=$storePassword" >> android/key.properties
echo "keyPassword=$key_Password" >> android/key.properties
echo "keyAlias=upload" >> android/key.properties
echo "storeFile=../app/upload-keystore.jks" >> android/key.properties

echo "-------------------------------------------------"
echo "ALL DONE!!!"
echo "-------------------------------------------------"
