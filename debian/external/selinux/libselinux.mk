NAME = libselinux

cc_defaults_target_host_cflags = -DBUILD_HOST

cc_library_cflags = -DUSE_PCRE2

cc_defaults_srcs = \
	src/booleans.c \
	src/callbacks.c \
	src/freecon.c \
	src/label_backends_android.c \
	src/label.c \
	src/label_support.c \
	src/matchpathcon.c \
	src/setrans_client.c \
	src/sha1.c \

cc_library_srcs = \
	src/label_file.c \
	src/regex.c \

cc_library_target_linux_srcs = \
	src/avc.c \
	src/avc_internal.c \
	src/avc_sidtab.c \
	src/compute_av.c \
	src/compute_create.c \
	src/compute_member.c \
	src/context.c \
	src/deny_unknown.c \
	src/enabled.c \
	src/fgetfilecon.c \
	src/getenforce.c \
	src/getfilecon.c \
	src/get_initial_context.c \
	src/init.c \
	src/lgetfilecon.c \
	src/load_policy.c \
	src/lsetfilecon.c \
	src/mapping.c \
	src/procattr.c \
	src/reject_unknown.c \
	src/setenforce.c \
	src/setexecfilecon.c \
	src/setfilecon.c \
	src/stringrep.c \

cc_extra = \
	src/setenforce.c \
	src/lsetfilecon.c \
	src/selinux_config.c \
	src/policyvers.c \
	src/check_context.c \
	src/lgetfilecon.c \
	src/disable.c \
	src/seusers.c \
	src/canonicalize_context.c \

SOURCES = $(cc_defaults_srcs) $(cc_library_srcs) $(cc_library_target_linux_srcs) $(cc_extra)
SOURCES := $(foreach source, $(SOURCES), libselinux/$(source))
CFLAGS += \
    -DNO_PERSISTENTLY_STORED_PATTERNS \
    -DDISABLE_SETRANS \
    -DDISABLE_BOOL \
    -D_GNU_SOURCE \
    -DNO_MEDIA_BACKEND \
    -DNO_X_BACKEND \
    -DNO_DB_BACKEND
CPPFLAGS += -Ilibselinux/include -Ilibsepol/include -DHOST
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
	         -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android -lpcre \
	         -Ldebian/out -lsepol

build: $(SOURCES)
	mkdir --parents debian/out
	$(CC) $^ -o debian/out/$(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/$(NAME).so