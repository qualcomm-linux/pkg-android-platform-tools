NAME := libadb

LIBADB_SRC_FILES := \
    adb.cpp \
    adb_io.cpp \
    adb_listeners.cpp \
    adb_trace.cpp \
    adb_unique_fd.cpp \
    adb_utils.cpp \
    fdevent.cpp \
    services.cpp \
    sockets.cpp \
    socket_spec.cpp \
    sysdeps/errno.cpp \
    transport.cpp \
    transport_fd.cpp \
    transport_local.cpp \
    transport_usb.cpp \

LIBADB_posix_srcs := \
    sysdeps_unix.cpp \
    sysdeps/posix/network.cpp \

LIBADB_linux_SRC_FILES := \
    client/auth.cpp \
    client/usb_dispatch.cpp \
    client/usb_libusb.cpp \
    client/usb_linux.cpp \

LOCAL_SRC_FILES := \
    $(LIBADB_SRC_FILES) \
    $(LIBADB_posix_srcs) \
    $(LIBADB_linux_SRC_FILES) \

LIBDIAGNOSE_USB_SRC_FILES = diagnose_usb/diagnose_usb.cpp

GEN := transport_mdns_unsupported.cpp

SOURCES := $(foreach source, $(LOCAL_SRC_FILES), adb/$(source)) $(LIBDIAGNOSE_USB_SRC_FILES) $(GEN)
SOURCES := $(foreach source, $(SOURCES), system/core/$(source))
CXXFLAGS += -std=gnu++2a
CPPFLAGS += \
            -I/usr/include/android \
            -Isystem/core/adb \
            -Isystem/core/base/include \
            -Isystem/core/diagnose_usb/include \
            -Isystem/core/libcrypto_utils/include \
            -Isystem/core/include \
            -Iexternal/boringssl/include \
            -DPLATFORM_TOOLS_VERSION='"$(PLATFORM_TOOLS_VERSION)"' \
            -DADB_HOST=1 -DADB_VERSION='"$(DEB_VERSION)"'

LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android -Ldebian/out/external/boringssl -lcrypto \
           -lpthread -Lsystem/core -lbase -lcutils -lcrypto_utils -lusb-1.0

system/core/$(NAME).so: $(SOURCES)
	$(CXX) $^ -o system/core/$(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 system/core/$(NAME).so

system/core/transport_mdns_unsupported.cpp:
	echo 'void init_mdns_transport_discovery(void) {}' > system/core/transport_mdns_unsupported.cpp

clean:
	$(RM) system/core/$(NAME).so* system/core/transport_mdns_unsupported.cpp
