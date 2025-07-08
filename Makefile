# Makefile for building Red Hat Best Practices Guide
# Builds both HTML and PDF outputs using containerized build process

# Variables
PODMAN := podman
MAIN_DOC := main.adoc
HTML_TEMPLATE := quay.io/redhat-docs/redhat-docs-template
PDF_TEMPLATE := quay.io/redhat-docs/redhat-docs-pdf-template
ASSETS_DIR := assets
PDF_ASSETS_DIR := pdf-assets
OUTPUT_HTML := index.html
OUTPUT_PDF := main.pdf

# Default target
.PHONY: all
all: html pdf

# Help target
.PHONY: help
help:
	@echo "Red Hat Best Practices Guide Build System"
	@echo "=========================================="
	@echo ""
	@echo "Available targets:"
	@echo "  all       - Build both HTML and PDF (default)"
	@echo "  html      - Build HTML output (index.html)"
	@echo "  pdf       - Build PDF output (main.pdf)"
	@echo "  clean     - Remove generated files and assets"
	@echo "  help      - Show this help message"
	@echo ""
	@echo "Requirements:"
	@echo "  - podman must be installed and available in PATH"
	@echo "  - Internet connection for pulling container images"

# Build HTML output
.PHONY: html
html: $(OUTPUT_HTML)

$(OUTPUT_HTML): $(MAIN_DOC) $(ASSETS_DIR)
	@echo "Building HTML output..."
	$(PODMAN) run --rm -it -v "$(CURDIR)":/docs:Z $(HTML_TEMPLATE) $(MAIN_DOC)
	@echo "HTML build complete: $(OUTPUT_HTML)"

# Set up HTML assets
$(ASSETS_DIR):
	@echo "Setting up HTML assets..."
	$(PODMAN) pull $(HTML_TEMPLATE)
	$(PODMAN) cp $$($(PODMAN) run --detach $(HTML_TEMPLATE)):/assets ./$(ASSETS_DIR)

# Build PDF output
.PHONY: pdf
pdf: $(OUTPUT_PDF)

$(OUTPUT_PDF): $(MAIN_DOC) $(PDF_ASSETS_DIR)
	@echo "Building PDF output..."
	$(PODMAN) run --rm -it -v "$(CURDIR)":/docs:Z $(PDF_TEMPLATE) $(MAIN_DOC)
	@echo "PDF build complete: $(OUTPUT_PDF)"

# Set up PDF assets
$(PDF_ASSETS_DIR):
	@echo "Setting up PDF assets..."
	$(PODMAN) pull $(PDF_TEMPLATE)
	$(PODMAN) cp $$($(PODMAN) run --detach $(PDF_TEMPLATE)):/pdf-assets ./$(PDF_ASSETS_DIR)

# Clean generated files
.PHONY: clean
clean:
	@echo "Cleaning generated files..."
	rm -f $(OUTPUT_HTML) $(OUTPUT_PDF)
	rm -rf $(ASSETS_DIR) $(PDF_ASSETS_DIR)
	@echo "Clean complete"

# Force rebuild targets
.PHONY: force-html force-pdf
force-html: clean-html html
force-pdf: clean-pdf pdf

# Clean specific outputs
.PHONY: clean-html clean-pdf
clean-html:
	rm -f $(OUTPUT_HTML)
	rm -rf $(ASSETS_DIR)

clean-pdf:
	rm -f $(OUTPUT_PDF)
	rm -rf $(PDF_ASSETS_DIR)

# Check if podman is available
.PHONY: check-podman
check-podman:
	@which $(PODMAN) > /dev/null || (echo "Error: $(PODMAN) not found. Please install podman." && exit 1)

# Make all build targets depend on podman check
html: check-podman
pdf: check-podman 