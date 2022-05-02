NAME = libnativehelper

SOURCES = \
  JNIHelp.cpp \
  JniConstants.cpp \
  toStringArray.cpp \
  JniInvocation.cpp \

SOURCES := $(foreach source, $(SOURCES), libnativehelper/$(source))
OBJECTS = $(SOURCES:.cpp=.o)

CXXFLAGS += -std=gnu++2a
CPPFLAGS += \
  -I/usr/include/android \
  -Ilibnativehelper/header_only_include \
  -Ilibnativehelper/include \
  -Ilibnativehelper/include_jni \
  -Ilibnativehelper/platform_include \
  -Isystem/core/base/include \
  -Isystem/core/liblog/include \

LDFLAGS += \
  -Ldebian/out/system/core \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Wl,-soname,$(NAME).so.0 \
  -ldl \
  -llog \
  -shared

build: $(OBJECTS)
	mkdir -p debian/out/libnativehelper
	$(CXX) $^ -o debian/out/libnativehelper/$(NAME).so.0 $(LDFLAGS)
	cd debian/out/libnativehelper && ln -s $(NAME).so.0 $(NAME).so

$(OBJECTS): %.o: %.cpp
	$(CXX) -c -o $@ $< $(CXXFLAGS) $(CPPFLAGS)
