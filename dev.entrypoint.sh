#!/bin/bash

case "$1" in
    bash)
        git config --global user.email "wbison3@gmail.com"
        git config --global user.name "Alfredo Rodríguez"
        /bin/bash
        ;;

    *)
        echo "What's that?"
        ;;
esac

exit 0
