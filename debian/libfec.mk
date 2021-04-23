NAME = libfec

# copied from libfec/Android.bp
SOURCES = \
        fec_open.cpp \
        fec_read.cpp \
        fec_verity.cpp \
        fec_process.cpp \

CSOURCES := $(foreach source, $(filter %.c, $(SOURCES)), libfec/$(source))
CXXSOURCES := $(foreach source, $(filter %.cpp, $(SOURCES)), libfec/$(source))
CXXFLAGS += -fno-strict-aliasing -std=g++17
CPPFLAGS += \
            -Iext4_utils/include \
            -Ilibfec/include \
            -D_GNU_SOURCE -DFEC_NO_KLOG -D_LARGEFILE64_SOURCE
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
           -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -L/usr/lib/$(DEB_HOST_MULTIARCH)/android \
           -lbase -lsparse -lselinux

build: $(COBJECTS) $(CXXOBJECTS)
	mkdir -p $(OUT_DIR)
	$(CXX) $^ -o $(OUT_DIR)/$(NAME).so.0 $(LDFLAGS)
	ln -s $(NAME).so.0 $(OUT_DIR)/$(NAME).so

clean:
	$(RM) $(CXXOBJECTS) $(COBJECTS) $(NAME).so*

$(COBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)

$(CXXOBJECTS): %.o: %.cpp
	$(CXX) $< -o $@ $(CXXFLAGS) $(CPPFLAGS)
