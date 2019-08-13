#!/bin/bash
# $1 is j32 or j64
cd ~

source $jmake/common.sh

# gcc 5 vs 4 - killing off linux asm routines (overflow detection)
# new fast code uses builtins not available in gcc 4
# use -DC_NOMULTINTRINSIC to continue to use more standard c in version 4
# too early to move main linux release package to gcc 5

USE_OPENMP="${USE_OPENMP:=0}"
if [ $USE_OPENMP -eq 1 ] ; then
OPENMP=" -fopenmp "
LDOPENMP=" -fopenmp "
if [ -z "${compiler##*gcc*}" ] || [ -z "${CC##*gcc*}" ]; then
LDOPENMP32=" -l:libgomp.so.1 "    # gcc
else
LDOPENMP32=" -l:libomp.so.5 "     # clang
fi
fi

javx2="${javx2:=0}"

case $jplatform\_$1 in

linux_j32) # linux x86
TARGET=libj.so
# faster, but sse2 not available for 32-bit amd cpu
# sse does not support mfpmath=sse in 32-bit gcc
COMPILE="$common -m32 -msse2 -mfpmath=sse -DC_NOMULTINTRINSIC "
# slower, use 387 fpu and truncate extra precision
# COMPILE="$common -m32 -ffloat-store "
LINK=" -shared -Wl,-soname,libj.so -m32 -lm -ldl $LDOPENMP32 -o libj.so "
OBJS_AESNI=" aes-ni.o "
;;

linux_j64nonavx) # linux intel 64bit nonavx
TARGET=libj.so
COMPILE="$common "
LINK=" -shared -Wl,-soname,libj.so -lm -ldl $LDOPENMP -o libj.so "
OBJS_AESNI=" aes-ni.o "
;;

linux_j64) # linux intel 64bit avx
TARGET=libj.so
COMPILE="$common -DC_AVX=1 "
LINK=" -shared -Wl,-soname,libj.so -lm -ldl $LDOPENMP -o libj.so "
if [ "x$javx2" != x'1' ] ; then
CFLAGS_SIMD=" -mavx "
else
CFLAGS_SIMD=" -DC_AVX2=1 -mavx2 "
fi
OBJS_FMA=" blis/gemm_int-fma.o "
OBJS_AESNI=" aes-ni.o "
;;

raspberry_j32) # linux raspbian arm
TARGET=libj.so
COMPILE="$common -marm -march=armv6 -mfloat-abi=hard -mfpu=vfp -DRASPI -DC_NOMULTINTRINSIC "
LINK=" -shared -Wl,-soname,libj.so -lm -ldl $LDOPENMP -o libj.so "
;;

raspberry_j64) # linux arm64
TARGET=libj.so
COMPILE="$common -march=armv8-a+crc -DRASPI -DC_CRC32C=1 "
LINK=" -shared -Wl,-soname,libj.so -lm -ldl $LDOPENMP -o libj.so "
;;

darwin_j32) # darwin x86
TARGET=libj.dylib
COMPILE="$darwin -m32 $macmin"
LINK=" -dynamiclib -lm -ldl $LDOPENMP -m32 $macmin -o libj.dylib"
OBJS_AESNI=" aes-ni.o "
;;

darwin_j64nonavx) # darwin intel 64bit nonavx
TARGET=libj.dylib
COMPILE="$darwin $macmin"
LINK=" -dynamiclib -lm -ldl $LDOPENMP $macmin -o libj.dylib"
OBJS_AESNI=" aes-ni.o "
;;

darwin_j64) # darwin intel 64bit
TARGET=libj.dylib
COMPILE="$darwin $macmin -DC_AVX=1"
LINK=" -dynamiclib -lm -ldl $LDOPENMP $macmin -o libj.dylib"
if [ "x$javx2" != x'1' ] ; then
CFLAGS_SIMD=" -mavx "
else
CFLAGS_SIMD=" -DC_AVX2=1 -mavx2 "
fi
OBJS_FMA=" blis/gemm_int-fma.o "
OBJS_AESNI=" aes-ni.o "
;;

*)
echo no case for those parameters
exit
esac

echo "COMPILE=$COMPILE"

OBJS="\
 a.o \
 ab.o \
 aes-c.o \
 aes-sse2.o \
 af.o \
 ai.o \
 am.o \
 am1.o \
 amn.o \
 ao.o \
 ap.o \
 ar.o \
 as.o \
 au.o \
 blis/gemm_c-ref.o \
 blis/gemm_int-aarch64.o \
 blis/gemm_int-avx.o \
 blis/gemm_int-sse2.o \
 blis/gemm_vec-ref.o \
 c.o \
 ca.o \
 cc.o \
 cd.o \
 cf.o \
 cg.o \
 ch.o \
 cip.o \
 cl.o \
 cp.o \
 cpdtsp.o \
 cpuinfo.o \
 cr.o \
 crs.o \
 ct.o \
 cu.o \
 cv.o \
 cx.o \
 d.o \
 dc.o \
 dss.o \
 dstop.o \
 dsusp.o \
 dtoa.o \
 f.o \
 f2.o \
 fbu.o \
 gemm.o \
 i.o \
 io.o \
 j.o \
 jdlllic.o \
 k.o \
 m.o \
 mbx.o \
 p.o \
 pv.o \
 px.o \
 r.o \
 rl.o \
 rt.o \
 s.o \
 sc.o \
 sha1-arm.o \
 sha256-arm.o \
 sl.o \
 sn.o \
 t.o \
 u.o \
 v.o \
 v0.o \
 v1.o \
 v2.o \
 va1.o \
 va1ss.o \
 va2.o \
 va2s.o \
 va2ss.o \
 vamultsp.o \
 vb.o \
 vbang.o \
 vbit.o \
 vcant.o \
 vchar.o \
 vcat.o \
 vcatsp.o \
 vcomp.o \
 vcompsc.o \
 vd.o \
 vdx.o \
 ve.o \
 vf.o \
 vfft.o \
 vfrom.o \
 vfromsp.o \
 vg.o \
 vgauss.o \
 vgcomp.o \
 vgranking.o \
 vgsort.o \
 vgsp.o \
 vi.o \
 viavx.o \
 viix.o \
 visp.o \
 vm.o \
 vo.o \
 vp.o \
 vq.o \
 vrand.o \
 vrep.o \
 vs.o \
 vsb.o \
 vt.o \
 vu.o \
 vx.o \
 vz.o \
 w.o \
 wc.o \
 wn.o \
 ws.o \
 x.o \
 x15.o \
 xa.o \
 xaes.o \
 xb.o \
 xc.o \
 xcrc.o \
 xd.o \
 xf.o \
 xfmt.o \
 xh.o \
 xi.o \
 xl.o \
 xo.o \
 xs.o \
 xsha.o \
 xt.o \
 xu.o "

export OBJS OBJS_FMA OBJS_AESNI COMPILE CFLAGS_SIMD LINK TARGET
$jmake/domake.sh $1

