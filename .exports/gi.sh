#!/bin/bash

# Command line interface to gitignore.io
function gi() { curl -L -s "https://www.gitignore.io/api/$*" ;}
