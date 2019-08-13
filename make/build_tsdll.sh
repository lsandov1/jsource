#!/bin/bash
# $1 is j32 or j64
cd ~

source $jmake/common.sh

case $jplatform\_$1 in

linux_j32)
TARGET=libtsdll.so
COMPILE="$common -m32 "
LINK=" -shared -Wl,-soname,libtsdll.so  -m32 -o libtsdll.so -lm "
;;
linux_j64)
TARGET=libtsdll.so
COMPILE="$common "
LINK=" -shared -Wl,-soname,libtsdll.so -o libtsdll.so -lm "
;;
raspberry_j32)
TARGET=libtsdll.so
COMPILE="$common -marm -march=armv6 -mfloat-abi=hard -mfpu=vfp"
LINK=" -shared -Wl,-soname,libtsdll.so -o libtsdll.so -lm "
;;
raspberry_j64)
TARGET=libtsdll.so
COMPILE="$common -march=armv8-a+crc "
LINK=" -shared -Wl,-soname,libtsdll.so -o libtsdll.so -lm "
;;
darwin_j32)
TARGET=libtsdll.dylib
COMPILE="$darwin -m32 $macmin"
LINK=" -m32 $macmin -dynamiclib -o libtsdll.dylib -lm "
;;
darwin_j64)
TARGET=libtsdll.dylib
COMPILE="$common $macmin"
LINK=" $macmin -dynamiclib -o libtsdll.dylib -lm "
;;
*)
echo no case for those parameters
exit
esac

echo "COMPILE=$COMPILE"

OBJS="tsdll.o "
export OBJS COMPILE LINK TARGET
$jmake/domake.sh $1

