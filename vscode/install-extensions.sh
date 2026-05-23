#!/bin/sh

while read e; do
  codium --install-extension "$e"
done <extensions.txt