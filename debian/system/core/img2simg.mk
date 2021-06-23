NAME = img2simg

SOURCES = system/core/libsparse/img2simg.cpp

CPPFLAGS += \
  -I/usr/include/android \
  -Isystem/core/libsparse/include \
  -Isystem/core/include \
  -std=gnu++17 \

LDFLAGS += -lz
STATIC_LIBS = \
  debian/out/system/core/libsparse.a \
  debian/out/system/core/libbase.a \
  debian/out/system/core/liblog.a \

debian/out/system/core/$(NAME): $(SOURCES)
	mkdir --parents debian/out/system/core
	$(CXX) -o $@ $^ $(CPPFLAGS) $(STATIC_LIBS) $(LDFLAGS)
