CXX ?= /usr/bin/c++
TRACY_FLAGS ?= -DTRACY_ENABLE -DTRACY_ON_DEMAND -DTRACY_DEMANGLE
CXX_FLAGS ?= -std=c++17 -g -fPIC

# See https://dub.pm/package-format-json#environment-variables

# Sociomantic / Bosagora setup was to have flat submodules.
#
# Hence a user of the Tracyd library (which itself has a `tracy` submodule)
# would have `submodules/tracyd` (with `submodules/tracyd/submodules/tracy`
# being an **uninitialized** and **unused** submodule) and `submodule/tracy`.
# This would allow fine-control from the application over its dependencies.
#
# The default here follows the same pattern but allows for other ones.
# Most users might want to have `tracy` checked out somewhere,
# e.g. `source/3rd-party/tracy`, in which case provide a `TRACY_SOURCE_DIR`
# variable this makefile pointing to `source/3rd-party/tracy` and ignore
# the `ROOT_PACKAGE_DIR` variable.
# To control output, provide `TRACY_TARGET_DIR`.

ROOT_PACKAGE_DIR ?= .
DUB_ROOT_PACKAGE_TARGET_PATH ?= .

TRACY_SOURCE_DIR ?= $(ROOT_PACKAGE_DIR)/submodules/tracy
ifneq ($(DUB_ROOT_PACKAGE_TARGET_PATH),)
TRACY_TARGET_DIR ?= $(DUB_ROOT_PACKAGE_TARGET_PATH)
else
TRACY_TARGET_DIR ?= .
endif

CLIENT_SOURCE := $(TRACY_SOURCE_DIR)/public/TracyClient.cpp
CLIENT_TARGET := $(TRACY_TARGET_DIR)/TracyClient.o

all: $(CLIENT_TARGET)

$(CLIENT_TARGET): $(CLIENT_SOURCE)
	$(CXX) -c $(CXX_FLAGS) $(TRACY_FLAGS) $(CLIENT_SOURCE) -o $(CLIENT_TARGET)

clean:
	rm -f $(CLIENT_TARGET)
