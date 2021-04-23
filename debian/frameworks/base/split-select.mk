NAME = split-select
SOURCES = \
          Abi.cpp \
          Grouper.cpp \
          Rule.cpp \
          RuleGenerator.cpp \
          SplitDescription.cpp \
          SplitSelector.cpp \
          Main.cpp \

SOURCES := $(foreach source, $(SOURCES), frameworks/base/tools/split-select/$(source))
CPPFLAGS += -Iframeworks/base/tools \
            -Iframeworks/base/libs/androidfw/include \
            -I/usr/include/android \
            -D_DARWIN_UNLIMITED_STREAMS \
            -DANDROID \
            -fmessage-length=0 \
            -fno-exceptions \
            -fno-strict-aliasing \
            -no-canonical-prefixes \
            -O2 \

CXXFLAGS += -std=gnu++17
LDFLAGS += -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -llog -lutils -Ldebian/out/frameworks/base -landroidfw -laapt

debian/out/frameworks/base/$(NAME): $(SOURCES)
	mkdir --parents debian/out/frameworks/base
	$(CXX) $^ -o debian/out/frameworks/base/$(NAME) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
