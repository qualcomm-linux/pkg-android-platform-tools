NAME = simg2img

SOURCES = \
  simg2img.cpp \
  sparse_crc32.cpp \

SOURCES := $(foreach source, $(SOURCES), system/core/libsparse/$(source))
OBJECTS = $(SOURCES:.cpp=.o)

CXXFLAGS += -std=gnu++17
CPPFLAGS += \
  -Isystem/core/libsparse/include \

LDFLAGS += \
  -Ldebian/out/system/core \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -lbase \
  -llog \
  -lpthread \
  -lsparse \

# -latomic should be the last library specified
# https://github.com/android/ndk/issues/589
ifneq ($(filter armel mipsel,$(DEB_HOST_ARCH)),)
  LDFLAGS += -latomic
endif

debian/out/system/core/$(NAME): $(OBJECTS)
	$(CXX) -o $@ $^ $(LDFLAGS)

$(OBJECTS): %.o: %.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(CPPFLAGS)
