#!/bin/bash
# $1 is j32 or j64
cd ~

source $jmake/common.sh

case $jplatform\_$1 in

linux_j32)
if [ "$USE_LINENOISE" -ne "1" ] ; then
COMPILE="$common -m32 -DREADLINE"
LINK=" -m32 -ldl -o jconsole "
else
COMPILE="$common -m32 -DREADLINE -DUSE_LINENOISE"
LINK=" -m32 -ldl -o jconsole "
OBJSLN="linenoise.o"
fi
;;
linux_j64)
if [ "$USE_LINENOISE" -ne "1" ] ; then
COMPILE="$common -DREADLINE"
LINK=" -ldl -o jconsole "
else
COMPILE="$common -DREADLINE -DUSE_LINENOISE"
LINK=" -ldl -o jconsole "
OBJSLN="linenoise.o"
fi
;;
raspberry_j32)
if [ "$USE_LINENOISE" -ne "1" ] ; then
COMPILE="$common -marm -march=armv6 -mfloat-abi=hard -mfpu=vfp -DREADLINE -DRASPI"
LINK=" -ldl -o jconsole "
else
COMPILE="$common -marm -march=armv6 -mfloat-abi=hard -mfpu=vfp -DREADLINE -DUSE_LINENOISE -DRASPI"
LINK=" -ldl -o jconsole "
OBJSLN="linenoise.o"
fi
;;
raspberry_j64)
if [ "$USE_LINENOISE" -ne "1" ] ; then
COMPILE="$common -march=armv8-a+crc -DREADLINE -DRASPI"
LINK=" -ldl -o jconsole "
else
COMPILE="$common -march=armv8-a+crc -DREADLINE -DUSE_LINENOISE -DRASPI"
LINK=" -ldl -o jconsole "
OBJSLN="linenoise.o"
fi
;;
darwin_j32)
if [ "$USE_LINENOISE" -ne "1" ] ; then
COMPILE="$darwin -m32 -DREADLINE $macmin"
LINK=" -ldl -m32 $macmin -o jconsole "
else
COMPILE="$darwin -m32 -DREADLINE -DUSE_LINENOISE $macmin"
LINK=" -ldl -m32 $macmin -o jconsole "
OBJSLN="linenoise.o"
fi
;;
#-mmacosx-version-min=10.5
darwin_j64)
if [ "$USE_LINENOISE" -ne "1" ] ; then
COMPILE="$darwin -DREADLINE $macmin"
LINK=" -ldl $macmin -o jconsole "
else
COMPILE="$darwin -DREADLINE -DUSE_LINENOISE $macmin"
LINK=" -ldl $macmin -o jconsole "
OBJSLN="linenoise.o"
fi
;;
*)
echo no case for those parameters
exit
esac

OBJS="jconsole.o jeload.o ${OBJSLN}"
TARGET=jconsole
export OBJS COMPILE LINK TARGET
$jmake/domake.sh $1

