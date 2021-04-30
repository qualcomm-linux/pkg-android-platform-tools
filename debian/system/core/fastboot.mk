NAME = fastboot
fastboot_SOURCES = \
          bootimg_utils.cpp \
          fastboot.cpp \
          fastboot_driver.cpp \
          fs.cpp \
          main.cpp \
          socket.cpp \
          tcp.cpp \
          udp.cpp \
          usb_linux.cpp \
          util.cpp \

fs_mgr_liblp_SOURCES := \
        builder.cpp \
        images.cpp \
        partition_opener.cpp \
        reader.cpp \
        utility.cpp \
        writer.cpp \

SOURCES := \
  $(foreach source, $(fastboot_SOURCES), system/core/fastboot/$(source)) \
  $(foreach source, $(fs_mgr_liblp_SOURCES), system/core/fs_mgr/liblp/$(source)) \

CXXFLAGS += -std=gnu++2a -fpermissive
CPPFLAGS += \
            -I/usr/include/android \
            -DPLATFORM_TOOLS_VERSION='"$(PLATFORM_TOOLS_VERSION)"' \
            -D_FILE_OFFSET_BITS=64 \
            -Isystem/core/include \
            -Isystem/core/mkbootimg/include/bootimg \
            -Isystem/core/adb \
            -Isystem/core/base/include \
            -Isystem/core/demangle/include \
            -Isystem/core/diagnose_usb/include \
            -Isystem/core/fs_mgr/include \
            -Isystem/core/fs_mgr/include_fstab \
            -Isystem/core/fs_mgr/liblp/include \
            -Isystem/core/libsparse/include \
            -Isystem/core/libziparchive/include \
            -Iexternal/boringssl/include \
            -Isystem/extras/ext4_utils/include \

LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -fuse-ld=gold \
           -Wl,-rpath-link system/core \
           -Lsystem/core -Ldebian/out/external/boringssl -lziparchive -lsparse -lbase -lcutils -ladb -lcrypto -lext4_utils \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -Ldebian/out/system/extras \
           -l7z \

# -latomic should be the last library specified
# https://github.com/android/ndk/issues/589
ifneq ($(filter armel mipsel,$(DEB_HOST_ARCH)),)
  LDFLAGS += -latomic
endif

system/core/fastboot/$(NAME): $(SOURCES)
	$(CXX) $^ -o system/core/fastboot/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) system/core/fastboot/$(NAME)
