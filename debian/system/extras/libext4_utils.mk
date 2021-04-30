NAME = libext4_utils

ext4_utils_SOURCES := \
        ext4_utils.cpp \
        wipe.cpp \
        ext4_sb.cpp \

squashfs_utils_SOURCES := \
        squashfs_utils.c \

SOURCES := \
  $(foreach source, $(ext4_utils_SOURCES), system/extras/ext4_utils/$(source)) \
  $(foreach source, $(squashfs_utils_SOURCES), system/extras/squashfs_utils/$(source)) \

CXXFLAGS += -fno-strict-aliasing -std=g++17
CPPFLAGS += \
            -Isystem/extras/ext4_utils/include \
            -Isystem/extras/libfec/include \
            -Isystem/extras/squashfs_utils \
            -I/usr/include/android \
            -Iexternal/selinux/libselinux/include \
            -D_GNU_SOURCE -DFEC_NO_KLOG -DSQUASHFS_NO_KLOG -D_LARGEFILE64_SOURCE \

LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -Ldebian/out/external/selinux -lbase -lsparse -lselinux

debian/out/system/extras/libext4_utils.so: $(SOURCES)
	mkdir --parents debian/out/system/extras/
	$(CC) $^ -o debian/out/system/extras/$(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/system/extras/$(NAME).so
