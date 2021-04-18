NAME = adb

SOURCES = client/adb_client.cpp \
	client/bugreport.cpp \
	client/commandline.cpp \
	client/file_sync_client.cpp \
	client/main.cpp \
	client/console.cpp \
	client/adb_install.cpp \
	client/line_printer.cpp \
	shell_service_protocol.cpp

SOURCES := $(foreach source, $(SOURCES), system/core/adb/$(source))
CXXFLAGS += -std=gnu++2a
CPPFLAGS += -I/usr/include/android -Isystem/core/include -Isystem/core/adb -Isystem/core/base/include \
            -DADB_VERSION='"$(DEB_VERSION)"' -DADB_HOST=1 -D_GNU_SOURCE
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android -Wl,-rpath-link system/core \
           -lpthread -Lsystem/core -ladb -lbase

# -latomic should be the last library specified
# https://github.com/android/ndk/issues/589
ifneq ($(filter armel mipsel,$(DEB_HOST_ARCH)),)
  LDFLAGS += -latomic
endif

system/core/adb/$(NAME): $(SOURCES)
	$(CXX) $^ -o system/core/adb/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)

clean:
	$(RM) system/core/adb/$(NAME)
