NAME = dexdump
SOURCES = dexdump_cfg.cc dexdump_main.cc dexdump.cc
SOURCES := $(foreach source, $(SOURCES), art/dexdump/$(source))

CPPFLAGS += \
  -Iart/libartbase \
  -Iart/dexdump \
  -Iart/libdexfile \
  -Iart/runtime \
  -I/usr/include/android/nativehelper \
  -I/usr/include/android \
  -Umips \

CXXFLAGS += -std=gnu++17

# libsigchain defines wrapper functions around sigaction() family. In order to
# override the ones provided by libc, libsignal must appear in the shared
# object dependency tree before libc in the breadth-first order.
LDFLAGS += -nodefaultlibs \
  -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Ldebian/out/art \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android
LIBRARIES_FLAGS += \
  -lsigchain \
  -lc \
  -lstdc++ \
  -lgcc_s \
  -lart \
  -lbase \

debian/out/art/$(NAME): $(SOURCES)
	$(CXX) $^ -o $@ $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LIBRARIES_FLAGS)
