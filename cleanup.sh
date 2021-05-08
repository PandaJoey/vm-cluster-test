#!/bin/bash

echo "####################"
echo "unmounting drives."
echo "####################"
multipass unmount ~/nodejoinfiles master
multipass unmount ~/nodejoinfiles worker-1
multipass unmount ~/nodejoinfiles worker-2

multipass stop master worker-1 worker-2
multipass delete master worker-1 worker-2

sudo snap remove multipass
