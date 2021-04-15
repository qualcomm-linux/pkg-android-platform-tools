NAME = libnativehelper
SOURCES = JNIHelp.cpp \
          JniConstants.cpp \
          toStringArray.cpp \
          JniInvocation.cpp \

CXXFLAGS += -std=c++17
CPPFLAGS += \
  -Iinclude_jni \
  -Iinclude \
  -Iheader_only_include \
  -Iplatform_include \
  -I/usr/include/android \

LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 -ldl -lpthread \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android -llog

build: $(SOURCES)
	$(CXX) $^ -o $(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 $(NAME).so