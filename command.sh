#PROJECT_NAME="gtp"

#DISPLAY_NAME="GTP App"
#CLASS_NAME="GTP"
ORG_DIR=../Bit-Merge-Mobile-master

echo "Please enter your project name:"
# shellcheck disable=SC2162
read PROJECT_NAME

##For creating and importing project.
flutter create --org com.gtp "$PROJECT_NAME"
echo "-------------------------------------------------"
echo "CREATED PROJECT $PROJECT_NAME"
echo "-------------------------------------------------"

##Copying required directories.
cp -r $ORG_DIR/lib $PROJECT_NAME
cp -r $ORG_DIR/assets $PROJECT_NAME
cp -r $ORG_DIR/pubspec.yaml $PROJECT_NAME
#cp -r $ORG_DIR/android/build.gradle $PROJECT_NAME/android

##Changing required directories.
# shellcheck disable=SC2016

find $PROJECT_NAME/lib -type f -exec sed -i "" "s/bit_merge_mobile/$PROJECT_NAME/g" {} +
#find "$PROJECT_NAME"/lib -type f -exec sed -i "s/BitMerge/$CLASS_NAME/g" {} +
sed -i "" "s/bit_merge_mobile/$PROJECT_NAME/g" $PROJECT_NAME/pubspec.yaml
sed -i "" "s/<desc>/A new project with Commands./g" $PROJECT_NAME/pubspec.yaml

cd $PROJECT_NAME || exit

##Deleting directories.
rm -r test

##Pub get for dependencies.
flutter pub upgrade

echo "Please enter your App name:"
# shellcheck disable=SC2162
read DISPLAY_NAME

##For changing name of app

dart run ../rename_app/main.dart all="$DISPLAY_NAME"

#echo "please enter git repository:"
#read  -r z
#echo
#
#git init
#git add .
#echo "Please enter the commit message:"
#read -r commit_message
#git commit -m "$commit_message"
#git remote add origin "$repository"
#git push -u origin master

#echo "Please Enter store password:"
#read -r storePassword
#echo
#
#echo "Please Enter key password:"
#read -r  key_Password
#echo
#
## Validation or other checks can be added here if needed
#
#keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA \
#  -keysize 2048 -validity 10000 -alias upload -storepass "$storePassword" -keypass "$key_Password"
#
## Update key.properties file with dynamic password
#echo "storePassword=$storePassword" >> android/key.properties
#echo "keyPassword=$key_Password" >> android/key.properties
#echo "keyAlias=upload" >> android/key.properties
#echo "storeFile=../app/upload-keystore.jks" >> android/key.properties


dart run ../app-icon-generator/lib/main.dart

cp -r android/app/src/main/res/ ../app-icon-generator/android/
# Remove the original Android resources
rm -r ../app-icon-generator/android/
cp -r ios/Runner/ ../app-icon-generator/ios/
# Remove the original Ios resources
rm -r ../app-icon-generator/ios/

echo "-------------------------------------------------"
echo "ALL DONE!!!"
echo "-------------------------------------------------"
