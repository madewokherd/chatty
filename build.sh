#!/bin/sh

haxe chatty/core/*.hx -js jsout.js -D node || exit 1

