NAME = dexlist
SOURCES = dexlist.cc
SOURCES := $(foreach source, $(SOURCES), art/dexlist/$(source))
CPPFLAGS += \
  -Iart/libartbase \
  -Iart/libdexfile \
  -Iart/runtime \
  -I/usr/include/android/nativehelper \
  -I/usr/include/android \
  -Umips \

CXXFLAGS += -std=gnu++17

# See the comment in `dexdump.mk`
LDFLAGS += -nodefaultlibs \
  -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Ldebian/out/art \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android
LIBRARIES_FLAGS += \
  -lbase \
  -lsigchain \
  -lc \
  -lstdc++ \
  -lgcc_s \
  -lart \

debian/out/art/$(NAME): $(SOURCES)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LIBRARIES_FLAGS)
