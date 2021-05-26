NAME = libnativeloader
SOURCES = native_loader.cpp
SOURCES := $(foreach source, $(SOURCES), art/libnativeloader/$(source))

CPPFLAGS += \
  -I/usr/include/android \
  -Isystem/core/include \
  -Isystem/core/base/include \
  -Iart/libnativebridge/include \
  -Iart/libnativeloader/include \
  -Ilibnativehelper/include_jni \
  -Ilibnativehelper/include \
  -Ilibnativehelper/header_only_include \

CXXFLAGS += -std=gnu++2a

LDFLAGS += \
  -shared -Wl,-soname,$(NAME).so.0 \
  -ldl \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Lsystem/core \
  -Ldebian/out/art \
  -lnativebridge -lbase

debian/out/art/$(NAME).so.0: $(SOURCES)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/art/$(NAME).so
