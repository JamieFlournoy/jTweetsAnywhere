#!/bin/sh

if [ -z `ls tools/yuicompressor-*.jar` ]; then
    echo "Download YUI Compressor from http://developer.yahoo.com/yui/compressor/ and put the JAR in the tools/ directory."
    echo
    exit 1
fi

JS_LIB_NAME_PREFIX="jquery.jtweetsanywhere"
JS_LIB_VERSION="1.2.1"
JS_LIB_DIR=lib
SOURCE_JS=$JS_LIB_DIR/${JS_LIB_NAME_PREFIX}-${JS_LIB_VERSION}.js
DEST_JS=$JS_LIB_DIR/${JS_LIB_NAME_PREFIX}-${JS_LIB_VERSION}.min.js

YUI_COMPRESSOR_JAR=`ls tools/yuicompressor*.jar | head -1`

echo "Minifying $SOURCE_JS using YUI Compressor at $YUI_COMPRESSOR_JAR"
java -jar $YUI_COMPRESSOR_JAR -o $DEST_JS $SOURCE_JS

ORIGINAL_BYTES=`du $SOURCE_JS | sed 's/lib.*//'`
MINIFIED_BYTES=`du $DEST_JS | sed 's/lib.*//'`
let "MINIFICATION_PERCENT = 100 * $MINIFIED_BYTES / $ORIGINAL_BYTES"
echo "Minified ($MINIFICATION_PERCENT% smaller) as $DEST_JS"
