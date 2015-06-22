#!/bin/bash
export JAVA_HOME=/opt/{{jdk_extract_dir}}
export JRE_HOME=$JAVA_HOME/jre
export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin

