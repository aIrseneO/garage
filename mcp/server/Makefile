CURRENT_DIR = $(subst /Makefile,,$(abspath $(lastword $(MAKEFILE_LIST))))

install-dependencies:
	@uv sync --frozen --no-dev --no-editable

run:
	@uv run $(CURRENT_DIR)/src/main.py
	