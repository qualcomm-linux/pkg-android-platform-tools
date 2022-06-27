NAME = hprof-conv

SOURCES = dalvik/tools/hprof-conv/HprofConv.c
LDFLAGS += -pie

debian/out/dalvik/tools/$(NAME): $(SOURCES)
	mkdir -p debian/out/dalvik/tools
	$(CC) -o $@ $^ $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
