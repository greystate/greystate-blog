PROJECT_FOLDER="/Users/chriz/Development/src/greystate-blog"
BUILD_FOLDER="$PROJECT_FOLDER/build"

DEPLOY_DIRECTORY="/Users/chriz/Development/src/greystate.github.io"

# echo "Build the blog's year pages"
# xsltproc -o $OUTPUT_DIR/index.html year.xslt navigation.xml

echo "Make any missing directories"
if [[ ! -e "$DEPLOY_DIRECTORY/assets" ]]; then
	mkdir	$DEPLOY_DIRECTORY/assets
fi
if [[ ! -e "$DEPLOY_DIRECTORY/images" ]]; then
	mkdir	$DEPLOY_DIRECTORY/images
fi

echo "Copy assets over"
cp $BUILD_FOLDER/assets/*.* "$DEPLOY_DIRECTORY/assets"
cp $BUILD_FOLDER/images/*.* "$DEPLOY_DIRECTORY/images"

echo "Remove the post.html files in the build directories"
find "$BUILD_FOLDER" -name "post.html" -delete

echo "Copy new index page"
cp "$BUILD_FOLDER/index.html" "$DEPLOY_DIRECTORY"

echo "Copy new about page"
cp "$BUILD_FOLDER/who/index.html" "$DEPLOY_DIRECTORY/who"

echo "Copy new resources page"
cp "$BUILD_FOLDER/resources/index.html" "$DEPLOY_DIRECTORY/resources"

echo "Copy over the complete blog structure"
cp -R "$BUILD_FOLDER/log" "$DEPLOY_DIRECTORY"

