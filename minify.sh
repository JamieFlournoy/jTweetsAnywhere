#!/bin/sh

if [ -z `ls tools/yuicompressor-*.jar` ]; then
    echo "Download YUI Compressor from http://developer.yahoo.com/yui/compressor/ and put the JAR in the tools/ directory."
    echo
    exit 1
fi

JS_LIB_NAME_PREFIX="jquery.jtweetsanywhere"
JS_LIB_VERSION="1.2.1"
SOURCE_JS=${JS_LIB_NAME_PREFIX}-${JS_LIB_VERSION}.js
DEST_JS=${JS_LIB_NAME_PREFIX}-${JS_LIB_VERSION}.min.js

YUI_COMPRESSOR_JAR=`ls tools/yuicompressor*.jar | head -1`

echo "Minifying jTweetsAnywhere Using YUI Compressor at $YUI_COMPRESSOR_JAR"
java -jar $YUI_COMPRESSOR_JAR lib/$SOURCE_JS > lib/$DEST_JS
