NAME = libnativehelper
SOURCES = JNIHelp.cpp \
          JniConstants.cpp \
          toStringArray.cpp \
          JniInvocation.cpp
SOURCES := $(foreach source, $(SOURCES), libnativehelper/$(source))

CXXFLAGS += -std=c++17
CPPFLAGS += \
  -Ilibnativehelper/include_jni \
  -Ilibnativehelper/include \
  -Ilibnativehelper/header_only_include \
  -Ilibnativehelper/platform_include \
  -I/usr/include/android \

LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 -ldl -lpthread \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android -llog

libnativehelper/$(NAME).so.0: $(SOURCES)
	$(CXX) $^ -o libnativehelper/$(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 libnativehelper/$(NAME).so
