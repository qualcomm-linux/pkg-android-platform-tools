NAME = hprof-conv
SOURCES = HprofConv.c
SOURCES := $(foreach source, $(SOURCES), dalvik/tools/hprof-conv/$(source))

debian/out/dalvik/tools/$(NAME): $(SOURCES)
	mkdir --parents debian/out/dalvik/tools
	$(CC) $^ -o debian/out/dalvik/tools/$(NAME) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
