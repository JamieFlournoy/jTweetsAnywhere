#!/bin/sh

JS_LIB_NAME_PREFIX="jquery.jtweetsanywhere"
JS_LIB_VERSION="1.2.1"
JS_LIB_DIR=lib
SOURCE_JS=$JS_LIB_DIR/${JS_LIB_NAME_PREFIX}-${JS_LIB_VERSION}.js
DEST_JS=$JS_LIB_DIR/${JS_LIB_NAME_PREFIX}-${JS_LIB_VERSION}.min.js

#COMPRESSOR_VARIANT="yui"
COMPRESSOR_VARIANT="closure"

if [ "$COMPRESSOR_VARIANT" = "yui" ]; then
  COMPRESSOR_JAR=`ls tools/yuicompressor*.jar 2>/dev/null | head -1`
  COMPRESSOR_ARGS="-o $DEST_JS $SOURCE_JS"
  COMPRESSOR_NAME="YUI Compressor"
  COMPRESSOR_URL="http://developer.yahoo.com/yui/compressor/"
else
  if [ "$COMPRESSOR_VARIANT" = "closure" ]; then
    COMPRESSOR_JAR=`ls tools/compiler.jar 2>/dev/null | head -1`
    COMPRESSOR_ARGS="--js=$SOURCE_JS --js_output_file=$DEST_JS"
    COMPRESSOR_NAME="Closure Compiler"
    COMPRESSOR_URL="http://closure-compiler.googlecode.com/files/compiler-latest.zip"
  fi
fi

if [ -z $COMPRESSOR_JAR ]; then
    echo "The $COMPRESSOR_NAME library is missing.\nDownload $COMPRESSOR_NAME from $COMPRESSOR_URL and put the JAR in the tools/ directory.\n\n"
    exit 1
fi

echo "Minifying $SOURCE_JS using $COMPRESSOR_NAME at $COMPRESSOR_JAR"

java -jar $COMPRESSOR_JAR $COMPRESSOR_ARGS

ORIGINAL_BYTES=`du $SOURCE_JS | sed 's/lib.*//'`
MINIFIED_BYTES=`du $DEST_JS | sed 's/lib.*//'`
let "MINIFICATION_PERCENT = 100 * ($ORIGINAL_BYTES - $MINIFIED_BYTES) / $ORIGINAL_BYTES"
echo "Minified ($MINIFICATION_PERCENT% smaller) as $DEST_JS"
