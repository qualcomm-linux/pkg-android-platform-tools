
include /usr/share/dpkg/architecture.mk

NAME = aapt
SOURCES = Main.cpp
SOURCES := $(foreach source, $(SOURCES), frameworks/base/tools/aapt/$(source))
CPPFLAGS += -DSTATIC_ANDROIDFW_FOR_TOOLS \
            -DAAPT_VERSION=\"$(ANDROID_BUILD_TOOLS_VERSION)\" \
            -Iframeworks/base/libs/androidfw/include \
            -I/usr/include/android \
            -DANDROID \
            -fmessage-length=0 \
            -fno-exceptions \
            -fno-strict-aliasing \
            -no-canonical-prefixes \
            -O2 \

CXXFLAGS += -std=gnu++17
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -Wl,-rpath-link=debian/out/frameworks/base -Ldebian/out/frameworks/base -laapt \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android -lutils

# -latomic should be the last library specified
# https://github.com/android/ndk/issues/589
ifeq ($(DEB_HOST_ARCH), armel)
  LDFLAGS += -latomic
endif
ifeq ($(DEB_HOST_ARCH), mipsel)
  LDFLAGS += -latomic
endif

debian/out/frameworks/base/$(NAME): $(SOURCES)
	mkdir --parents debian/out/frameworks/base
	$(CXX) $^ -o debian/out/frameworks/base/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
