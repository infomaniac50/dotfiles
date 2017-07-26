#!/usr/bin/env bash

export ANDROID_HOME=${HOME}/prefix/opt/android-sdk
export ANDROID_STUDIO=${HOME}/prefix/opt/android-studio

pathappend $ANDROID_HOME/emulator
pathappend $ANDROID_HOME/tools
pathappend $ANDROID_HOME/tools/bin
pathappend $ANDROID_HOME/platform-tools

pathappend $ANDROID_STUDIO/gradle/gradle-3.2/bin
pathappend $ANDROID_STUDIO/bin

if command_exists emulator; then
  # You won't get any error messages with this. So if your emulator doesn't seem to start, then try running it directly.
  # Let's you run your emulators like <avd name> <emulator options>.
  # See emulator -help for emulator options reference.
  for avd in $(emulator -list-avds); do
      eval "$avd() { nohup emulator @$avd \$@ > /dev/null 2> /dev/null & disown; }";
  done
fi
