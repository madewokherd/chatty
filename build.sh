#!/bin/sh

haxe chatty/core/*.hx chatty/js/*.hx -main chatty.js.Main -js chatty.js || exit 1

