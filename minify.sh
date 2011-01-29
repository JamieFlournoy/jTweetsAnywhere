#!/bin/sh

if [ -z `ls tools/yuicompressor-*.jar` ]; then
    echo "Download YUI Compressor and put the JAR in the tools/ directory."
    exit 1
fi

YUI_COMPRESSOR_JAR=`ls tools/yuicompressor*.jar | head -1`
echo "Minifying jTweetsAnywhere Using YUI Compressor at $YUI_COMPRESSOR_JAR"
java -jar $YUI_COMPRESSOR_JAR jquery.jtweetsanywhere-1.2.1.js > jquery.jtweetsanywhere-1.2.1.min.js
