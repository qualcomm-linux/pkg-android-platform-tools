NAME = libnativebridge
SOURCES = native_bridge.cc
SOURCES := $(foreach source, $(SOURCES), art/libnativebridge/$(source))

CPPFLAGS += \
  -I/usr/include/android \
  -Ilibnativehelper/include_jni \
  -Isystem/core/include \
  -Isystem/core/base/include \
  -Iart/libnativebridge/include \
  -Isystem/core/liblog/include \

CXXFLAGS += -std=gnu++2a

LDFLAGS += \
  -shared -Wl,-soname,$(NAME).so.0 \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -ldl \
  -Lsystem/core \
  -llog

debian/out/art/$(NAME).so.0: $(SOURCES)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/art/$(NAME).so
