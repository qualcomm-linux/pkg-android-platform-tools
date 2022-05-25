NAME = libbase

SOURCES = \
  abi_compatibility.cpp \
  chrono_utils.cpp \
  cmsg.cpp \
  file.cpp \
  liblog_symbols.cpp \
  logging.cpp \
  mapped_file.cpp \
  parsebool.cpp \
  parsenetaddress.cpp \
  process.cpp \
  properties.cpp \
  stringprintf.cpp \
  strings.cpp \
  threads.cpp \
  test_utils.cpp \
  \
  errors_unix.cpp

SOURCES := $(foreach source, $(SOURCES), system/core/base/$(source))
OBJECTS = $(SOURCES:.cpp=.o)

CXXFLAGS += -std=gnu++2a
CPPFLAGS += \
  -D_FILE_OFFSET_BITS=64 \
  -Isystem/core/base/include \
  -Isystem/core/include \

LDFLAGS += \
  -Ldebian/out/system/core \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Wl,-soname,$(NAME).so.0 \
  -llog \
  -lpthread \
  -shared

# -latomic should be the last library specified
# https://github.com/android/ndk/issues/589
ifneq ($(filter armel mipsel,$(DEB_HOST_ARCH)),)
  LDFLAGS += -latomic
endif

build: $(OBJECTS)
	$(CXX) $^ -o debian/out/system/core/$(NAME).so.0 $(LDFLAGS)
	ln -sf $(NAME).so.0 debian/out/system/core/$(NAME).so

$(OBJECTS): %.o: %.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(CPPFLAGS)
