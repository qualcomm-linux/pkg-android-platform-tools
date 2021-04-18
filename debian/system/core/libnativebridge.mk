NAME = libnativebridge
SOURCES = native_bridge.cc
SOURCES := $(foreach source, $(SOURCES), system/core/libnativebridge/$(source))

CPPFLAGS += \
  -I/usr/include/android \
  -I/usr/include/android/nativehelper \
  -Isystem/core/include \
  -Isystem/core/base/include \
  -Isystem/core/libnativebridge/include \

CXXFLAGS += -std=gnu++2a

LDFLAGS += \
  -shared -Wl,-soname,$(NAME).so.0 \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -ldl \
  -Lsystem/core \
  -llog

system/core/$(NAME).so.0: $(SOURCES)
	$(CXX) $^ -o system/core/$(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 system/core/$(NAME).so

clean:
	$(RM) system/core/$(NAME).so*
