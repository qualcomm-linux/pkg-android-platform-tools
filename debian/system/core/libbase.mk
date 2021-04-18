NAME = libbase
SOURCES = \
          chrono_utils.cpp \
          cmsg.cpp \
          errors_unix.cpp \
          file.cpp \
          logging.cpp \
          mapped_file.cpp \
          parsenetaddress.cpp \
          properties.cpp \
          quick_exit.cpp \
          stringprintf.cpp \
          strings.cpp \
          test_utils.cpp \
          threads.cpp \

SOURCES := $(foreach source, $(SOURCES), system/core/base/$(source))
CXXFLAGS += -std=gnu++17 -D_FILE_OFFSET_BITS=64
CPPFLAGS += -I/usr/include/android -Isystem/core/include -Isystem/core/base/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0

system/core/$(NAME).so.0: $(SOURCES)
	$(CXX) $^ -o system/core/$(NAME).so.0 $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 system/core/$(NAME).so

clean:
	$(RM) system/core/$(NAME).so*
