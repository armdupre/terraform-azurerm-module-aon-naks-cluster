SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

############################################################
# Terragrunt config
############################################################

TG := time terragrunt
TG_FLAGS := -auto-approve

############################################################
# Paths
############################################################

BICEP_DIR := ../../bicep
COMPILED_DIR := ../../compiled

FILE_BICEP := $(BICEP_DIR)/naks-cluster.bicep
FILE_JSON := $(COMPILED_DIR)/naks-cluster.json

BICEP_JOBS ?= $(shell nproc 2>/dev/null || echo 4)

############################################################
# BICEP BUILD
############################################################

$(COMPILED_DIR):
	mkdir -p $(COMPILED_DIR)

define BUILD_IF_CHANGED
	@src="$<"; \
	out="$@"; \
	sha_file="$(COMPILED_DIR)/$$(basename $<).sha256"; \
	new_sha="$$(sha256sum "$$src" | awk '{print $$1}')"; \
	old_sha="$$(cat "$$sha_file" 2>/dev/null || true)"; \
	if [[ -f "$$out" && "$$new_sha" == "$$old_sha" ]]; then \
		echo "skip $$src"; \
	else \
		echo "build $$src"; \
		az bicep build --file "$$src" --outfile "$$out"; \
		echo "$$new_sha" > "$$sha_file"; \
	fi
endef

$(FILE_JSON): $(FILE_BICEP) $(COMPILED_DIR)
	$(call BUILD_IF_CHANGED)

.PHONY: build

build:
	$(MAKE) -j $(BICEP_JOBS) $(FILE_JSON)

############################################################
# Terragrunt lifecycle
############################################################

all: build plan

init:
	@echo "=== $(TG) init ==="
	$(TG) init

validate:
	@echo "=== $(TG) validate ==="
	$(TG) validate

update:
	@echo "=== $(TG) update ==="
	$(TG) run -- get -update

render:
	@echo "=== $(TG) render ==="
	$(TG) render

plan:
	@echo "=== $(TG) plan ==="
	$(TG) plan

############################################################
# Cleanup
############################################################

clean-local:
	rm -rf $(COMPILED_DIR)
	rm -rf .terragrunt-cache

clean: destroy clean-local
