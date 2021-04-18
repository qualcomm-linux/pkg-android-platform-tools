NAME = libsparse
SOURCES = \
        backed_block.cpp \
        output_file.cpp \
        sparse.cpp \
        sparse_crc32.cpp \
        sparse_err.cpp \
        sparse_read.cpp \

CSOURCES := $(foreach source, $(filter %.c, $(SOURCES)), system/core/libsparse/$(source))
CXXSOURCES := $(foreach source, $(filter %.cpp, $(SOURCES)), system/core/libsparse/$(source))
COBJECTS := $(CSOURCES:.c=.o)
CXXOBJECTS := $(CXXSOURCES:.cpp=.o)
CFLAGS += -c
CXXFLAGS += -c -std=gnu++17
CPPFLAGS += -Isystem/core/include -Isystem/core/libsparse/include -Isystem/core/base/include
LDFLAGS += \
  -shared -Wl,-soname,$(NAME).so.0 \
  -lz \
  -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android \
  -Lsystem/core \
  -lbase


build: $(COBJECTS) $(CXXOBJECTS)
	$(CXX) $^ -o system/core/$(NAME).so.0 $(LDFLAGS)
	ln -s $(NAME).so.0 system/core/$(NAME).so

clean:
	$(RM) $(CXXOBJECTS) $(COBJECTS) system/core/$(NAME).so*

$(COBJECTS): %.o: %.c
	$(CC) $< -o $@ $(CFLAGS) $(CPPFLAGS)

$(CXXOBJECTS): %.o: %.cpp
	$(CXX) $< -o $@  $(CXXFLAGS) $(CPPFLAGS)
