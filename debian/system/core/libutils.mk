include /usr/share/dpkg/architecture.mk

NAME = libutils

SOURCES = \
  CallStack.cpp \
  FileMap.cpp \
  JenkinsHash.cpp \
  Looper.cpp \
  misc.cpp \
  NativeHandle.cpp \
  Printer.cpp \
  ProcessCallStack.cpp \
  PropertyMap.cpp \
  RefBase.cpp \
  SharedBuffer.cpp \
  StopWatch.cpp \
  String16.cpp \
  String8.cpp \
  StrongPointer.cpp \
  SystemClock.cpp \
  Threads.cpp \
  Timers.cpp \
  Tokenizer.cpp \
  Unicode.cpp \
  VectorImpl.cpp \

SOURCES := $(foreach source, $(SOURCES), system/core/libutils/$(source))
OBJECTS = $(SOURCES:.cpp=.o)

CXXFLAGS += -std=gnu++2a
CPPFLAGS += \
  -DLIBUTILS_NATIVE=1 \
  -I/usr/include/android \
  -Isystem/core/base/include \
  -Isystem/core/cutils/include \
  -Isystem/core/include \
  -Isystem/core/libbacktrace/include \
  -Isystem/core/libcutils/include \
  -Isystem/core/liblog/include \
  -Isystem/core/libprocessgroup/include \

LDFLAGS += \
  -Ldebian/out/system/core \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Wl,-soname,$(NAME).so.0 \
  -lbacktrace \
  -lcutils \
  -llog \
  -lpthread \
  -shared \

build: $(OBJECTS)
	$(CXX) $^ -o debian/out/system/core/$(NAME).so.0 $(LDFLAGS)
	cd debian/out/system/core && ln -sf $(NAME).so.0 $(NAME).so

$(OBJECTS): %.o: %.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(CPPFLAGS)
