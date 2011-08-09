VERSION = 0
SUBLEVEL = 0
DEVNUM = 2
NAME = Glossy Abelia

.DEFAULT_GOAL := sketch
OUSIA_TARGET :=	ousia
OUSIA_PLATFORM := arm-v7m
MEMORY_TARGET := jtag
BOARD := leach

# TODO Here needs improve, for not only depend on this specific hardware
ifeq ($(BOARD), leach)
	MCU := STM32F103RB
	PRODUCT_ID := LEACH001
	ERROR_LED_PORT := GPIOA
	ERROR_LED_PIN  := 0
	DENSITY := STM32_MEDIUM_DENSITY
endif

# TODO Here needs improve, for not only depend on this specific hardware
# Some target specific things
ifeq ($(MEMORY_TARGET), ram)
	LDSCRIPT := $(BOARD)/ram.ld
	VECT_BASE_ADDR := VECT_TAB_RAM
endif
ifeq ($(MEMORY_TARGET), flash)
	LDSCRIPT := $(BOARD)/flash.ld
	VECT_BASE_ADDR := VECT_TAB_FLASH
endif
ifeq ($(MEMORY_TARGET), jtag)
	LDSCRIPT := $(BOARD)/jtag.ld
	VECT_BASE_ADDR := VECT_TAB_BASE
endif

# Useful paths
ifeq ($(OUSIA_HOME),)
	SRCROOT := .
else
	SRCROOT := $(OUSIA_HOME)
endif

BUILD_PATH = build
INCLUDE_PATH := $(SRCROOT)/include
PLATFORM_PATH := $(SRCROOT)/platform
CORE_PATH := $(SRCROOT)/core
DRIVER_PATH := $(SRCROOT)/driver
FRAMEWORK_PATH := $(SRCROOT)/framework
SUPPORT_PATH := $(SRCROOT)/support
SCRIPT_PATH := $(SRCROOT)/script
SAMPLE_PATH := $(SRCROOT)/sample

# TODO Here needs improve, for not only depend on this specific hardware
GLOBAL_FLAGS :=	-DOUSIA \
                -D$(DENSITY) \
                -D$(VECT_BASE_ADDR) \
                -DBOARD_$(BOARD) \
                -DMCU_$(MCU) \
                -DERROR_LED_PORT=$(ERROR_LED_PORT) \
                -DERROR_LED_PIN=$(ERROR_LED_PIN)

GLOBAL_CFLAGS := -Os -g3 -gdwarf-2 -mcpu=cortex-m3 -mthumb -march=armv7-m \
                 -nostdlib -ffunction-sections -fdata-sections \
                 -Wl,--gc-sections $(GLOBAL_FLAGS) \
                 #-I$(SRCROOT)/include

GLOBAL_ASFLAGS := -mcpu=cortex-m3 -march=armv7-m -mthumb \
                  -x assembler-with-cpp $(GLOBAL_FLAGS)

LDDIR := $(PLATFORM_PATH)/ld
LDFLAGS = -T$(LDDIR)/$(LDSCRIPT) -L$(LDDIR) \
          -mcpu=cortex-m3 -mthumb -Xlinker \
          --gc-sections --print-gc-sections --march=armv7-m -Wall

# Set up build rules and some useful templates
include $(SUPPORT_PATH)/make/build-rules.mk
include $(SUPPORT_PATH)/make/build-templates.mk

# TODO Set all modules here
MODULES	:= $(CORE_PATH)
MODULES += $(PLATFORM_PATH)
MODULES += $(FRAMEWORK_PATH)

# call each module rules.mk
$(foreach m,$(MODULES),$(eval $(call MODULE_template,$(m))))

# Main target
include $(SUPPORT_PATH)/make/build-targets.mk

.PHONY: install sketch clean help debug cscope tags ctags ram flash jtag

# Download code to target device
install: sketch
	$(SHELL) ./script/download.sh

# Force a rebuild if the maple target changed
PREV_BUILD_TYPE = $(shell cat $(BUILD_PATH)/build-type 2>/dev/null)
build-check:
ifneq ($(PREV_BUILD_TYPE), $(MEMORY_TARGET))
	$(shell rm -rf $(BUILD_PATH))
endif

sketch: MSG_INFO build-check $(BUILD_PATH)/$(OUSIA_TARGET)

clean:
	rm -rf build

distclean:
	rm -rf build
	rm -rf tarball
	rm -f tags tags.ut tags.fn cscope.out

package:
	mkdir -p tarball
	$(SHELL) ./script/package.sh

help:
	@echo ""
	@echo "==========================================================="
	@echo "[Ousia Make Help]"
	@echo ""
	@echo "Build targets (default MEMORY_TARGET=flash):"
	@echo "  ram:       Compile sketch code to ram"
	@echo "  flash:     Compile sketch code to flash"
	@echo "  jtag:      Compile sketch code to jtag"
	@echo "  sketch:    Compile sketch code to target MEMORY_TARGET"
	@echo ""
	@echo "Downloading targets:"
	@echo "  install:   Download binary image to target device"
	@echo ""
	@echo "Debug targets:"
	@echo "  debug:     Start an openocd server"
	@echo ""
	@echo "Other targets:"
	@echo "  clean:     Remove all build files"
	@echo "  distclean: Remove all builds tarballs, and ohter misc"
	@echo "  help:      Show this message"
	@echo "  package:   Package current revision"
	@echo "==========================================================="
	@echo ""

debug:
	$(OPENOCD_WRAPPER) debug

ram:
	@$(MAKE) MEMORY_TARGET=ram --no-print-directory sketch

flash:
	@$(MAKE) MEMORY_TARGET=flash --no-print-directory sketch

jtag:
	@$(MAKE) MEMORY_TARGET=jtag --no-print-directory sketch

