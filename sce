#!/usr/bin/env bash

#check xmodmap
XMODMAP=$(which xmodmap)

if test "$?" != "0" ; then 
    echo 'Please install xmodmap'
    exit
fi

tmpname='/tmp/sce'
scefile='/tmp/.scefile'

if test -f "${scefile}"; then
    echo '
remove Lock = Caps_Lock
add Lock = Escape
keysym Caps_Lock = Escape
keysym Escape = Caps_Lock
' > ${tmpname}
    rm -f ${scefile}
    title='CapsLock'
    msg='Escape'
else
    echo '
remove Lock = Caps_Lock
add Lock = Escape
keysym Escape = Caps_Lock 
keysym Caps_Lock = Escape
' > ${tmpname}
    touch ${scefile}
    msg='CapsLock'
    title='Escape'
fi

xmodmap ${tmpname}

if test $(which notify-send) != "" ; then
    notify-send -t 5000 ${title} ${msg}
fi

rm -f ${tmpname}
