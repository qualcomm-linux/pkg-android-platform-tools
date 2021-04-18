NAME = libnativeloader
SOURCES = native_loader.cpp
SOURCES := $(foreach source, $(SOURCES), system/core/libnativeloader/$(source))

CPPFLAGS += \
  -Isystem/core/include \
  -Isystem/core/base/include \
  -Isystem/core/libnativebridge/include \
  -Isystem/core/libnativeloader/include \
  -I/usr/include/android/nativehelper \

CXXFLAGS += -std=gnu++2a

LDFLAGS += \
  -shared -Wl,-soname,$(NAME).so.0 \
  -ldl \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Lsystem/core \
  -lnativebridge -lbase

build: $(SOURCES)
	$(CXX) $^ -o system/core/$(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 system/core/$(NAME).so

clean:
	$(RM) system/core/$(NAME).so*
