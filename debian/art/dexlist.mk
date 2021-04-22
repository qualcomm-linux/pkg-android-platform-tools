NAME = dexlist
SOURCES = dexlist.cc
SOURCES := $(foreach source, $(SOURCES), dexlist/$(source))
CPPFLAGS += \
  -Ilibartbase \
  -Ilibdexfile \
  -Iruntime \
  -I/usr/include/android/nativehelper \

CXXFLAGS += -std=gnu++17

# See the comment in `dexdump.mk`
LDFLAGS += -nodefaultlibs \
  -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Ldebian/out \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android
LIBRARIES_FLAGS += \
  -lbase \
  -lsigchain \
  -lc \
  -lstdc++ \
  -lgcc_s \
  -lart \

debian/out/$(NAME): $(SOURCES)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LIBRARIES_FLAGS)
