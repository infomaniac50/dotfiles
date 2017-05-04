export ANDROID_HOME=${HOME}/prefix/opt/android-sdk
pathappend $ANDROID_HOME/tools
pathappend $ANDROID_HOME/platform-tools

if command_exists emulator; then
  # You won't get any error messages with this. So if your emulator doesn't seem to start, then try running it directly.
  # Let's you run your emulators like <avd name> <emulator options>.
  # See emulator -help for emulator options reference.
  for avd in $(emulator -list-avds); do
      eval "$avd() { nohup emulator @$avd \$@ > /dev/null 2> /dev/null & disown; }";
  done
fi