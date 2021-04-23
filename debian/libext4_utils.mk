NAME = libext4_utils

ext4_utils_SOURCES := \
        ext4_utils.cpp \
        wipe.cpp \
        ext4_sb.cpp \

squashfs_utils_SOURCES := \
        squashfs_utils.c \

SOURCES := \
  $(foreach source, $(ext4_utils_SOURCES), ext4_utils/$(source)) \
  $(foreach source, $(squashfs_utils_SOURCES), squashfs_utils/$(source)) \

CXXFLAGS += -fno-strict-aliasing -std=g++17
CPPFLAGS += \
            -Iext4_utils/include \
            -Ilibfec/include \
            -Isquashfs_utils \
            -I/usr/include/android \
            -D_GNU_SOURCE -DFEC_NO_KLOG -DSQUASHFS_NO_KLOG -D_LARGEFILE64_SOURCE
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lbase -lsparse -lselinux

build: $(SOURCES)
	mkdir --parents $(OUT_DIR)
	$(CC) $^ -o $(OUT_DIR)/$(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(OUT_DIR)/$(NAME).so
