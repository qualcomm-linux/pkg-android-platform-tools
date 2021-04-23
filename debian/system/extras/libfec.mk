NAME = libfec

# copied from libfec/Android.bp
SOURCES = \
        fec_open.cpp \
        fec_read.cpp \
        fec_verity.cpp \
        fec_process.cpp \

CSOURCES := $(foreach source, $(filter %.c, $(SOURCES)), system/extras/libfec/$(source))
CXXSOURCES := $(foreach source, $(filter %.cpp, $(SOURCES)), system/extras/libfec/$(source))
CXXFLAGS += -fno-strict-aliasing -std=g++17
CPPFLAGS += \
            -Isystem/extras/ext4_utils/include \
            -Isystem/extras/libfec/include \
	    -I/usr/include/android \
            -D_GNU_SOURCE -DFEC_NO_KLOG -D_LARGEFILE64_SOURCE
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lbase -lsparse -lselinux

debian/out/system/extras/libfec.so: $(COBJECTS) $(CXXOBJECTS)
	mkdir -p debian/out/system/extras/
	$(CXX) $^ -o debian/out/system/extras/$(NAME).so.0 $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/system/extras/$(NAME).so

clean:
	$(RM) $(CXXOBJECTS) $(COBJECTS) $(NAME).so*

$(COBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)

$(CXXOBJECTS): %.o: %.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)
