#!/bin/bash

#**************************** Create new project ***************************************

validate_project_name() {
  local project_name=$1
  if [[ $project_name =~ [[:space:]] || $project_name =~ [[:upper:]] || $project_name =~ [^a-zA-Z_] || $project_name =~ [[:digit:]] ]]; then
    echo "Invalid project name. Please use only lowercase letters without spaces, uppercase letters, special characters, or numbers."
    return 1
  else
    return 0
  fi
}

echo "Please enter your project name :"
read -r PROJECT_NAME

# Validate the project name
while ! validate_project_name "$PROJECT_NAME"; do
  echo "Please enter a valid project name :"
  read -r PROJECT_NAME
done

#**************************** Enter Domain name ***************************************
echo "please enter package name :"
read -r domain

# Get the current working directory
current_directory=$(pwd)
#echo "Current working directory: $current_directory"
cd ..
CUSTOM_PROJECT_DIR=$(pwd)/generated_project
echo "Default project directory path: $CUSTOM_PROJECT_DIR"

# Ask the user if they want to enter a custom path
echo "Do you want to change project directory path? (yes/no):"
read -r custom_path_choice

# New project path
if [ "$custom_path_choice" = "yes" ]; then
  echo "Please enter your project store path:"
  read -r project_path
  CUSTOM_PROJECT_DIR="$project_path"
else
  #  cd ..
  #  CUSTOM_PROJECT_DIR=$(pwd)/generated_project
  mkdir -p "$CUSTOM_PROJECT_DIR"
fi

#echo "CUSTOM_PROJECT_DIR directory: $CUSTOM_PROJECT_DIR"
#Structre Project Path
ORG_DIR="$current_directory/cubit_demo_project/Bit-Merge-Mobile-master"

#***************************** COMMAND TO CREATE-PROJECT ****************************************

flutter create --org $domain "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"
echo "-------------------------------------------------"
echo "CREATED PROJECT $CUSTOM_PROJECT_DIR/$PROJECT_NAME"
echo "-------------------------------------------------"

#**************************** COPY-FILES-TO-bit-merge-project ***************************************

cp -r "$ORG_DIR/lib" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"
cp -r "$ORG_DIR/assets" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"
cp -r "$ORG_DIR/pubspec.yaml" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"

#**************************** changes directory to project ***************************************

find "$CUSTOM_PROJECT_DIR"/"$PROJECT_NAME"/lib -type f -exec sed -i "" -e "s/bit_merge_mobile/$PROJECT_NAME/g" {} +
sed -i "" -e "s/bit_merge_mobile/$PROJECT_NAME/g" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/pubspec.yaml"
sed -i "" -e "s/<desc>/A new flutter project./g" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/pubspec.yaml"

#sed -i "" "s/bit_merge_mobile/$PROJECT_NAME/g" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/pubspec.yaml"
#sed -i "" "s/<desc>/A new flutter project./g" "$CUSTOM_PROJECT_DIR/$PROJECT_NAME/pubspec.yaml"
#/Volumes/Data/flutter/generating_sturcture_code/cubit_demo_project/Bit-Merge-Mobile-master/lib/packages/resources/src/theme.dart

#**************************** changes color theme ***************************************

DEMO_THEME_FILE="$current_directory/cubit_demo_project/Bit-Merge-Mobile-master/lib/packages/resources/src/theme.dart"
PROJECT_THEME_FILE="$CUSTOM_PROJECT_DIR/$PROJECT_NAME/lib/packages/resources/src/theme.dart"

cp "$DEMO_THEME_FILE" "$PROJECT_THEME_FILE"

echo "Do you want to customize the theme colors? (yes/no):"
read -r customize_colors

if [ "$customize_colors" = "yes" ]; then
  echo "Enter new primary color (e.g., blue, red, #RRGGBB):"
  read -r new_primary_color

  new_primary_color=${new_primary_color//#/}

  sed -i "" "s/primary: .*,/primary: Color(0xFF$new_primary_color),/g" "$PROJECT_THEME_FILE"
fi

sed -i "" "s/bit_merge_mobile/$PROJECT_NAME/g" "$PROJECT_THEME_FILE"

# Move to the newly created project directory
cd "$CUSTOM_PROJECT_DIR/$PROJECT_NAME" || exit

flutter pub upgrade

#**************************** APP-RENAME ***************************************
echo "Please enter your App name :"
read -r DISPLAY_NAME

dart run "$current_directory"/rename_app/main.dart all="$DISPLAY_NAME"

##**************************** Project add to GIT ***************************************
#
#echo "Please enter git repository:"
#read -r repository
#
#git init
#git add .
#echo "Please enter the commit message :"
#read -r commit_message
#git commit -m "$commit_message"
#git remote add origin "$repository"
#git push -u origin master
#
##**************************** key.properties-generated ***************************************
#
#echo "Please Enter store password (at least 6 characters):"
#while true; do
#  read -r storePassword
#  if [ ${#storePassword} -ge 6 ]; then
#    break
#  else
#    echo "Password must be at least 6 characters. Please try again."
#  fi
#done
#
#echo "Please Enter key password (at least 6 characters):"
#while true; do
#  read -r key_Password
#  if [ ${#key_Password} -ge 6 ]; then
#    break
#  else
#    echo "Password must be at least 6 characters. Please try again."
#  fi
#done
#
## Use expect to automate the keytool process
#expect - <<EOF
#spawn keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA \
#  -keysize 2048 -validity 10000 -alias upload -storepass "$storePassword" -keypass "$key_Password"
#expect {
#  "Is CN=*, OU=*, O=*, L=*, ST=*, C=* correct?" {
#    # Prompt user for confirmation
#    puts "Is the automatically generated information correct? (yes/no)"
#    expect_user -timeout -1 -re "(.*)\n"
#    set response \$expect_out(1,string)
#    if {\$response == "yes"} {
#      send "yes\r"
#    } else {
#      # User wants to manually input information
#      exp_continue
#    }
#  }
#  "Enter key password for <upload>" { send "$key_Password\r"; exp_continue }
#  "Re-enter new password:" { send "$storePassword\r" }
#}
#EOF
#
## Update key.properties file with dynamic password
#echo "storePassword=$storePassword" >> android/key.properties
#echo "keyPassword=$key_Password" >> android/key.properties
#echo "keyAlias=upload" >> android/key.properties
#echo "storeFile=../app/upload-keystore.jks" >> android/key.properties
##**************************** APP-ICON-GENERATED ***************************************
#
#
#generate_icons() {
#  echo "******************* Note: At this stage, you have to add your app icon path inside the required_files folder with filename app_icon; otherwise, it will take the default one *******************"
#  echo "Do you want to proceed? (y):"
#  read -r user_input
#
#  # Validate the user input
#  while [[ ! "$user_input" =~ ^[yY]$ ]]; do
#    echo "Invalid input. Please enter 'y' or 'Y'."
#    read -r user_input
#  done
#
#  #Get required_files directory
#  directory="$current_directory"/required_files/
#  appIconFile="app_icon.png"
#
#  if [ -e "$directory/$appIconFile" ]; then
#    dart run "$current_directory"/app_icon_generator/lib/main.dart "$current_directory" "${current_directory}"
#    cp -r "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"/android/app/src/main/res/ "$current_directory"/app_icon_generator/android/
#    # Remove the original Android resources
#    rm -r "$current_directory"/app_icon_generator/android/
#    cp -r "$CUSTOM_PROJECT_DIR/$PROJECT_NAME"/ios/Runner/ "$current_directory"/app_icon_generator/ios/
#    # Remove the original iOS resources
#    rm -r "$current_directory"/app_icon_generator/ios/
#  else
#    echo "******************** Error: $appIconFile not found in $directory ******************** "
#    echo "****** Please try again ******"
#    generate_icons
#  fi
#
#}
## Call the function
#generate_icons

dart run "$current_directory"/theme-generator/main.dart "$current_directory"
lightThemeJsonString=$(cat "${current_directory}"/theme-generator/light_theme.json)
echo "$lightThemeJsonString"

darkThemeJsonString=$(cat "${current_directory}"/theme-generator/dark_theme.json)
echo "$darkThemeJsonString"


extractJsonValue() {
  local key="$1"
   local jsonString="$2"
    local pattern="\"$key\":[^,}]*"

    if [[ $jsonString =~ $pattern ]]; then
    local match="${BASH_REMATCH[0]}"
    # Extract the value by removing the key and colon
    local value="${match##*:}"
    # Remove surrounding double quotes if present
    value="${value//\"/}"
    echo "$value"
  else
    echo "FFFFFF"
  fi
}


# Flag to indicate whether to perform the replacement
perform_replace_light=false
inside_block_light=false

# Read the original file line by line and create a temporary file for light theme
while IFS= read -r line; do
  if [[ $line =~ class\ AppTheme\ \{ ]]; then
    perform_replace_light=true
  fi

  if $perform_replace_light; then
    if [[ $line =~ lightTheme\ \{ ]]; then
      inside_block_light=true
    fi

    if $inside_block_light && [[ $line =~ \} ]]; then
      inside_block_light=false
    fi

    # Define the fields you want to replace for light theme
    fields=("primary" "onPrimary" "secondary" "onSecondary" "background" "onBackground" "surface"
      "onSurface" "surfaceVariant" "onSurfaceVariant" "error" "onError" "outline"
      "outlineVariant" "shadow" "secondaryContainer" "primaryContainer" "onPrimaryContainer"
      "inverseSurface" "tertiary" "tertiaryContainer" "surfaceTint")

    # Iterate over the fields and perform replacement for light theme
    for field in "${fields[@]}"; do
      if $inside_block_light && [[ $line =~ $field:\ .* ]]; then
        # Extract the color value from your JSON string for light theme (modify as needed)
        color_value=$(extractJsonValue "$field" "$lightThemeJsonString")

        # Replace the line with the new color value for light theme
        line="$field: Color(0xFF$color_value),"
      fi
    done
  fi

  echo "$line"
done <"$PROJECT_THEME_FILE" >"$PROJECT_THEME_FILE.tmp"

# Replace the original file with the modified temporary file for light theme
mv "$PROJECT_THEME_FILE.tmp" "$PROJECT_THEME_FILE"

# If dark theme data is provided, update dark theme
if [ -n "$darkThemeJsonString" ]; then
  # Flag to indicate whether to perform the replacement for dark theme
  perform_replace_dark=false
  inside_block_dark=false

  # Read the original file line by line and create a temporary file for dark theme
  while IFS= read -r line; do
    if [[ $line =~ class\ AppTheme\ \{ ]]; then
      perform_replace_dark=true
    fi

    if $perform_replace_dark; then
      if [[ $line =~ darkTheme\ \{ ]]; then
        inside_block_dark=true
      fi

      if $inside_block_dark && [[ $line =~ \} ]]; then
        inside_block_dark=false
      fi

      # Define the fields you want to replace for dark theme
      fields=("primary" "onPrimary" "secondary" "onSecondary" "background" "onBackground" "surface"
        "onSurface" "surfaceVariant" "onSurfaceVariant" "error" "onError" "outline"
        "outlineVariant" "shadow" "secondaryContainer" "primaryContainer" "onPrimaryContainer"
        "inverseSurface" "tertiary" "tertiaryContainer" "surfaceTint")

      # Iterate over the fields and perform replacement for dark theme
      for field in "${fields[@]}"; do
        if $inside_block_dark && [[ $line =~ $field:\ .* ]]; then
          # Extract the color value from your JSON string for dark theme (modify as needed)
          color_value=$(extractJsonValue "$field" "$darkThemeJsonString")

          # Replace the line with the new color value for dark theme
          line="$field: Color(0xFF$color_value),"
        fi
      done
    fi

    echo "$line"
  done <"$PROJECT_THEME_FILE" >"$PROJECT_THEME_FILE.tmp"

  # Replace the original file with the modified temporary file for dark theme
  mv "$PROJECT_THEME_FILE.tmp" "$PROJECT_THEME_FILE"
fi



# Replace the original file with the modified temporary file
mv "$PROJECT_THEME_FILE.tmp" "$PROJECT_THEME_FILE"

#rm "${current_directory}"/theme-generator/light_theme.json
echo "-------------------------------------------------"
echo "ALL DONE!!!"
echo "-------------------------------------------------"
