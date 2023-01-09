
#
# Java - this should work for Debian and Fedora.
# 
[ -z "$JAVA_HOME" -a -d /usr/lib/jvm/default-java ] \
    && JAVA_HOME="/usr/lib/jvm/default-java" && export JAVA_HOME
#
# My preferred locations for the Android SDK.
#
[ -d "$HOME/sw/android-sdk-linux" ] && ANDROID_HOME="$HOME/sw/android-sdk-linux"
[ -z "$ANDROID_HOME" -a -d /usr/local/sdk/android-sdk-linux ] \
    && ANDROID_HOME="/usr/local/sdk/android-sdk-linux" 
[ -z "$ANDROID_HOME" -a -d /usr/local/android-sdk-linux ] \
    && ANDROID_HOME="/usr/local/android-sdk-linux" 
[ -z "$ANDROID_HOME" -a -d /opt/android-studio/sdk ] && ANDROID_HOME="/opt/android-studio/sdk" 
export ANDROID_HOME

#
# Java/Android tools.
#
fuzzy_ensure_path -ep "$HOME/sw/gradle" /usr/local/gradle
fuzzy_ensure_path -b mvn -ep "$HOME/sw/apache-maven" /usr/local/apache-maven
if [ -n "$ANDROID_HOME" ]; then
    append_path "${ANDROID_HOME}/tools"
    append_path "${ANDROID_HOME}/platform-tools"
    [ -d "${ANDROID_HOME}/build-tools" ] \
        && append_path "${ANDROID_HOME}/build-tools/`ls ${ANDROID_HOME}/build-tools/ | sort | tail -n 1`"
fi
