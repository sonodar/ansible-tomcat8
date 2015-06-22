# disable default logging api
LOGGING_CONFIG=-Dnop

# logging
JAVA_OPTS="$JAVA_OPTS -Djuli-logback.configurationFile=file://$CATALINA_HOME/conf/logback.xml"
# memory settings
JAVA_OPTS="$JAVA_OPTS -Xms{{min_heap_size}} -Xmx{{max_heap_size}}"
JAVA_OPTS="$JAVA_OPTS -XX:MetaspaceSize={{metaspace_size}} -XX:MaxMetaspaceSize={{max_metaspace_size}}"
# dump settings
JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath={{heap_dump_dir}}"
# gc settings
JAVA_OPTS="$JAVA_OPTS -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled"
JAVA_OPTS="$JAVA_OPTS -XX:+PrintGCDetails -XX:+PrintGCDateStamps -verbose:gc -Xloggc:{{gc_log_file}}"
JAVA_OPTS="$JAVA_OPTS -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=7 -XX:GCLogFileSize=10M"
{% if ipv6_disable %}
# ipv6 disabled
JAVA_OPTS="$JAVA_OPTS -Djava.net.preferIPv4Stack=true"
{% endif %}

# JMX settings
export CATALINA_OPTS="-Dcom.sun.management.jmxremote=true
                      -Dcom.sun.management.jmxremote.ssl=false
                      -Dcom.sun.management.jmxremote.authenticate=false
                      -Djava.rmi.server.hostname=`hostname`"
