NAME = dexlist

SOURCES = art/dexlist/dexlist.cc

CXXFLAGS += -std=gnu++17
CPPFLAGS += \
  -Iart/libartbase \
  -Iart/libdexfile \
  -Iart/runtime \
  -Ilibnativehelper/include_jni \
  -I/usr/include/android \
  -Isystem/core/base/include \
  -Umips \

# libsigchain defines wrapper functions around sigaction() family.
# In order to override the ones provided by libc, libsignal must
# appear before libc in linker command invocation.
LDFLAGS += \
  -nodefaultlibs \
  -ldl \
  -lpthread \
  -lz \
  -llz4 \
  -Wl,-rpath=/usr/lib/p7zip \
  -L/usr/lib/p7zip -l:7z.so \
  -lc \
  -lstdc++ \
  -lgcc_s \

STATIC_LIBS = \
  debian/out/art/libart.a \
  debian/out/art/libnativeloader.a \
  debian/out/art/libnativebridge.a \
  debian/out/system/core/libbacktrace.a \
  debian/out/system/core/libcutils.a \
  debian/out/system/core/libziparchive.a \
  debian/out/system/core/libbase.a \
  debian/out/system/core/liblog.a \
  debian/out/art/libdexfile_support.a \
  debian/out/external/libunwind/libunwind.a \

debian/out/art/$(NAME): $(SOURCES)
	mkdir --parents debian/out/art
	$(CXX) -o $@ $^ $(CXXFLAGS) $(CPPFLAGS) $(STATIC_LIBS) $(LDFLAGS)
