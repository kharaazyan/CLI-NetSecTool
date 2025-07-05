# === Project Metadata ===
PROJECT      := sergo
VERSION      := 1.0.0

# === Directories ===
SRC_DIR      := src
INC_DIR      := include
BUILD_DIR    := build
BIN_DIR      := bin
DIST_DIR     := dist
TEST_DIR     := tests
DEPS_DIR     := deps
EXTERNAL_DIR := external

# === Tools ===
CXX          ?= g++
AR           ?= ar
RM           := rm -rf
MKDIR        := mkdir -p
CURL         := curl
WGET         := wget
GIT          := git

# === Flags ===
CXXFLAGS     := -std=c++20 -Wall -Wextra -I$(INC_DIR) -I$(EXTERNAL_DIR) -pthread
LDFLAGS      := -pthread -lcurl -lssl -lcrypto
DEBUG_FLAGS  := -g -O0 -DDEBUG
RELEASE_FLAGS:= -O2 -DNDEBUG

# === Build Type ===
BUILD        ?= debug
ifeq ($(BUILD),release)
    CXXFLAGS += $(RELEASE_FLAGS)
    BUILD_TYPE := Release
else
    CXXFLAGS += $(DEBUG_FLAGS)
    BUILD_TYPE := Debug
endif

# === Source/Objects/Deps ===
SRCS         := $(wildcard $(SRC_DIR)/*.cpp)
OBJS         := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SRCS))
DEPS         := $(OBJS:.o=.d)

# === Executable(s) ===
TARGET       := $(BIN_DIR)/$(PROJECT)
CLI_TARGET   := $(BIN_DIR)/cli

# === Colors ===
GREEN        := \033[0;32m
YELLOW       := \033[1;33m
RED          := \033[0;31m
BLUE         := \033[0;34m
NC           := \033[0m

# === Verbosity ===
V            ?= 0
ifeq ($(V),0)
    Q := @
else
    Q :=
endif

# === External Dependencies URLs ===
NLOHMANN_JSON_URL := https://github.com/nlohmann/json/releases/download/v3.12.0/json.hpp

# === Dependency Checks ===
.PHONY: check-deps install-deps check-system-libs download-external-deps

# Check system libraries
check-system-libs:
	@echo "$(BLUE)[INFO] Checking system libraries...$(NC)"
	@echo "$(BLUE)[INFO] Checking libcurl...$(NC)"
	@pkg-config --exists libcurl || \
		(echo "$(YELLOW)[WARN] libcurl not found. Installing...$(NC)" && \
		sudo apt-get install -y libcurl4-openssl-dev || true)
	
	@echo "$(BLUE)[INFO] Checking OpenSSL...$(NC)"
	@pkg-config --exists openssl || \
		(echo "$(YELLOW)[WARN] OpenSSL not found. Installing...$(NC)" && \
		sudo apt-get install -y libssl-dev || true)
	
	@echo "$(BLUE)[INFO] Checking pkg-config...$(NC)"
	@which pkg-config > /dev/null 2>&1 || \
		(echo "$(YELLOW)[WARN] pkg-config not found. Installing...$(NC)" && \
		sudo apt-get install -y pkg-config || true)
	@echo "$(GREEN)[✔] System libraries check passed$(NC)"

# Download external dependencies
download-external-deps:
	@echo "$(BLUE)[INFO] Downloading external dependencies...$(NC)"
	@mkdir -p $(EXTERNAL_DIR)
	
	# Download nlohmann/json
	@echo "$(BLUE)[INFO] Downloading nlohmann/json v3.12.0...$(NC)"
	@if [ ! -f $(EXTERNAL_DIR)/json.hpp ]; then \
		($(WGET) -q $(NLOHMANN_JSON_URL) -O $(EXTERNAL_DIR)/json.hpp || \
		$(CURL) -L -o $(EXTERNAL_DIR)/json.hpp $(NLOHMANN_JSON_URL)) && \
		echo "$(GREEN)[✔] nlohmann/json downloaded$(NC)" || \
		echo "$(RED)[ERROR] Failed to download nlohmann/json$(NC)"; \
	else \
		echo "$(GREEN)[✔] nlohmann/json already exists$(NC)"; \
	fi

# Check and install system dependencies
check-deps: check-system-libs
	@echo "$(BLUE)[INFO] Checking system dependencies...$(NC)"
	@which apt-get > /dev/null 2>&1 || \
		(echo "$(RED)[ERROR] apt-get not found. This makefile is for Ubuntu only.$(NC)" && exit 1)
	@echo "$(GREEN)[✔] System dependencies check passed$(NC)"

# Install all dependencies
install-deps: check-deps download-external-deps
	@echo "$(BLUE)[INFO] Installing build dependencies...$(NC)"
	@echo "$(BLUE)[INFO] Installing via apt-get...$(NC)"
	@sudo apt-get update || true
	@sudo apt-get install -y build-essential || true
	@sudo apt-get install -y curl wget git pkg-config || true
	@sudo apt-get install -y libcurl4-openssl-dev libssl-dev || true
	@echo "$(GREEN)[✔] Dependencies installation complete$(NC)"

# === Build Targets ===
.PHONY: all clean rebuild install uninstall test lint format docs help deps main cli

# Default target
all: deps main cli
	@echo "$(GREEN)[✔] Build complete ($(BUILD_TYPE))$(NC)"

# Dependencies target
deps: install-deps

# Build main executable
main: $(TARGET)
	@echo "$(GREEN)[✔] Main built successfully$(NC)"

# Build CLI executable
cli: $(CLI_TARGET)
	@echo "$(GREEN)[✔] CLI built successfully$(NC)"

$(TARGET): $(BUILD_DIR)/main.o | $(BIN_DIR)
	@echo "$(YELLOW)[Linking] $@$(NC)"
	$(Q)$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

$(CLI_TARGET): $(filter-out $(BUILD_DIR)/main.o,$(OBJS)) | $(BIN_DIR)
	@echo "$(YELLOW)[Linking] $@$(NC)"
	$(Q)$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	@echo "$(YELLOW)[Compiling] $<$(NC)"
	$(Q)$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

$(BUILD_DIR) $(BIN_DIR) $(DIST_DIR) $(DEPS_DIR) $(EXTERNAL_DIR):
	$(Q)$(MKDIR) $@

-include $(DEPS)

clean:
	$(Q)$(RM) $(BUILD_DIR) $(BIN_DIR) $(DIST_DIR)
	@echo "$(GREEN)[✔] Cleaned$(NC)"

clean-deps:
	$(Q)$(RM) $(DEPS_DIR)
	@echo "$(GREEN)[✔] Dependencies cleaned$(NC)"

clean-external:
	$(Q)$(RM) $(EXTERNAL_DIR)
	@echo "$(GREEN)[✔] External libraries cleaned$(NC)"

clean-all: clean clean-deps clean-external
	@echo "$(GREEN)[✔] All cleaned$(NC)"

rebuild: clean all

# === Installation Targets ===
install: $(TARGET) $(CLI_TARGET)
	@echo "$(BLUE)[INFO] Installing $(PROJECT)...$(NC)"
	@sudo cp $(TARGET) /usr/local/bin/ || \
		(echo "$(RED)[ERROR] Failed to install main. Try running with sudo.$(NC)" && exit 1)
	@sudo cp $(CLI_TARGET) /usr/local/bin/ || \
		(echo "$(RED)[ERROR] Failed to install cli. Try running with sudo.$(NC)" && exit 1)
	@echo "$(GREEN)[✔] $(PROJECT) and cli installed to /usr/local/bin/$(NC)"

uninstall:
	@echo "$(BLUE)[INFO] Uninstalling $(PROJECT)...$(NC)"
	@sudo rm -f /usr/local/bin/$(PROJECT) /usr/local/bin/cli || true
	@echo "$(GREEN)[✔] $(PROJECT) uninstalled$(NC)"

# === Help ===
help:
	@echo "$(BLUE)Sergo Decryptor Build System (Ubuntu Only)$(NC)"
	@echo ""
	@echo "$(GREEN)Usage:$(NC) make [target] [BUILD=debug|release] [V=1]"
	@echo ""
	@echo "$(GREEN)Build Targets:$(NC)"
	@echo "  all        - Build both main and cli (default)"
	@echo "  main       - Build only main executable"
	@echo "  cli        - Build only cli executable"
	@echo "  deps       - Install all dependencies"
	@echo "  clean      - Remove build artifacts"
	@echo "  clean-deps - Remove downloaded dependencies"
	@echo "  clean-external - Remove external libraries"
	@echo "  clean-all  - Remove all artifacts and dependencies"
	@echo "  rebuild    - Clean and build"
	@echo ""
	@echo "$(GREEN)Installation Targets:$(NC)"
	@echo "  install    - Install to system"
	@echo "  uninstall  - Remove from system"
	@echo ""
	@echo "$(GREEN)Variables:$(NC)"
	@echo "  BUILD      - debug (default) or release"
	@echo "  V          - Verbose build (V=1)"
	@echo ""
	@echo "$(GREEN)Dependencies:$(NC)"
	@echo "  C++20 compiler (g++)"
	@echo "  nlohmann/json v3.12.0"
	@echo "  libcurl (HTTP requests)"
	@echo "  libssl (encryption/decryption)"
	@echo "  termcolor (CLI colors)"
	@echo "  Standard Ubuntu libraries" 