#
#	Makefile for MatrixSSL library
#	Builds optimized shared library by default.
#	See comments below for building a debug library.
#	Copyright (c) PeerSec Networks, 2002-2004. All Rights Reserved.
#
CC      = mips-uclibc-gcc
STRIP   = mips-uclibc-strip
O       = .o
#SO      = .so
SO      = .a
E       =

#
#   Debug flags and C flags
#
DFLAGS	= -O3 -DLINUX #-DDEBUG
#
# To build a debug version of the MatrixSSL library, uncomment the DFLAGS line
# below and remove the strip command in the .so target below.
#
#DFLAGS	= -g -DDEBUG

CFLAGS  = -DLINUX $(DFLAGS)
LDFLAGS = -Wl -lc #-lpthread

all: compile

LIBRARIES = libmatrixssl$(SO)

OBJECTS	= matrixSsl$(O) \
		sslv3$(O) \
		cipherSuite$(O)	\
		os/malloc$(O) \
		os/linux/linux$(O)	\
		crypto/peersec/arc4$(O) \
		crypto/peersec/asn1$(O) \
		crypto/peersec/base64$(O) \
		crypto/peersec/des3$(O) \
		crypto/peersec/md5$(O) \
		crypto/peersec/mpi$(O) \
		crypto/peersec/rsa$(O) \
		crypto/peersec/sha1$(O) \
		../examples/sslSocket$(O)

compile: $(OBJECTS) $(LIBRARIES)

#
# Manual dependencies
#
*.o: ../matrixSsl.h matrixInternal.h matrixConfig.h Makefile
os/*.o: matrixInternal.h matrixConfig.h Makefile os/osLayer.h
os/linux/*.o: matrixInternal.h matrixConfig.h Makefile os/osLayer.h
crypto/peersec/*.o: matrixInternal.h matrixConfig.h Makefile \
					crypto/cryptoLayer.h crypto/peersec/pscrypto.h

#
# Remove the line 'strip matrixssl.so' if building debug
#
libmatrixssl.a: $(OBJECTS)
	#$(CC) -shared -nostdlib -o $@ $^ $(LDFLAGS)
	mips-uclibc-ar  -r $@ $^ 
	#$(STRIP) $(LIBRARIES)

#
#	Clean up workspace
#
clean:
	rm -f $(LIBRARIES) $(OBJECTS) 
