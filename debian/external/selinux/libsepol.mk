NAME := libsepol

srcs := \
        src/assertion.c \
        src/avrule_block.c \
        src/avtab.c \
        src/boolean_record.c \
        src/booleans.c \
        src/conditional.c \
        src/constraint.c \
        src/context.c \
        src/context_record.c \
        src/debug.c \
        src/ebitmap.c \
        src/expand.c \
        src/genbools.c \
        src/genusers.c \
        src/handle.c \
        src/hashtab.c \
        src/hierarchy.c \
        src/iface_record.c \
        src/interfaces.c \
        src/kernel_to_cil.c \
        src/kernel_to_common.c \
        src/kernel_to_conf.c \
        src/link.c \
        src/mls.c \
        src/module.c \
        src/module_to_cil.c \
        src/node_record.c \
        src/nodes.c \
        src/polcaps.c \
        src/policydb.c \
        src/policydb_convert.c \
        src/policydb_public.c \
        src/port_record.c \
        src/ports.c \
        src/roles.c \
        src/services.c \
        src/sidtab.c \
        src/symtab.c \
        src/user_record.c \
        src/users.c \
        src/util.c \
        src/write.c \

SOURCES = $(srcs)
SOURCES := $(foreach source, $(SOURCES), libsepol/$(source))
CFLAGS += \
    -D_GNU_SOURCE \
    -Wundef \
    -Wshadow \
    -Wmissing-noreturn \
    -Wmissing-format-attribute
CPPFLAGS += -Ilibsepol/include
LDFLAGS += -shared -Wl,-soname,$(NAME).so.0 \
	   -Wl,-rpath=/usr/lib/$(DEB_HOST_MULTIARCH)/android

build: $(SOURCES)
	mkdir --parents debian/out
	$(CC) $^ -o debian/out/$(NAME).so.0 $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
	ln -s $(NAME).so.0 debian/out/$(NAME).so