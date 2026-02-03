# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with content in this repository.

## Repository Overview

This repository contains the **CNF Best Practices Guide** - a comprehensive documentation resource providing guidance and requirements for developing Cloud Native Functions (CNFs) on the OpenShift Container Platform. The guide covers industry standards and best practices for containerized network functions.

The documentation was originally created in 2020 by Verizon with assistance from Red Hat and has evolved through many iterations to cover security, lifecycle management, networking, and other critical components.

**Published versions:**
- HTML: https://test-network-function.github.io/cnf-best-practices/
- PDF: https://github.com/test-network-function/cnf-best-practices/releases

## Documentation Format

The guide is written in **AsciiDoc** format using Red Hat's documentation templates:

- **Entry point:** `main.adoc` - The main assembly file that includes all modules
- **Modules:** `modules/` directory contains 80+ individual `.adoc` files, each covering a specific topic
- **Naming convention:** All module files follow the pattern `cnf-best-practices-<topic>.adoc`

## Content Structure

The documentation is organized into major sections:

### OpenShift Platform
- Helm charts
- Kubernetes fundamentals
- CNI/OVN networking
- Container Storage Interface (CSI)
- Storage types (block, ephemeral, local)
- Container runtime and CPU management
- Host OS and UBI base images
- Pod security and CI/CD

### User Plane Functions
- Hugepages configuration
- CPU isolation
- NUMA topology and awareness
- IPv4/IPv6 networking
- VRFs and routing instances
- Reserved ports

### Developer Guide
- CNF refactoring approaches
- Security best practices
- Linux capabilities
- OpenShift operations
- Application analysis
- Network security and secrets management
- SCC permissions

### Cloud Native Design Best Practices
- High-level CNF expectations
- Pod permissions and configuration
- Logging and monitoring
- Resource allocation (CPU, memory)
- Pod lifecycle (probes, termination, disruption budgets)
- Image tagging and init containers
- RBAC and custom roles
- Multus and SR-IOV networking
- Operator best practices
- OpenShift Virtualization (KubeVirt)

### CNF Requirements
- Comprehensive requirements checklist

## Build Commands

### Prerequisites
- `podman` (or `docker`) must be installed

### Building HTML
```bash
# Pull the template and extract assets
podman pull quay.io/redhat-docs/redhat-docs-template
podman cp $(podman run --detach quay.io/redhat-docs/redhat-docs-template):/assets ./assets

# Build HTML output
podman run --rm -it -v "$(pwd)":/docs:Z quay.io/redhat-docs/redhat-docs-template main.adoc
```

This generates `index.html` in the current directory.

### Building PDF
```bash
# Pull the PDF template and extract assets
podman pull quay.io/redhat-docs/redhat-docs-pdf-template
podman cp $(podman run --detach quay.io/redhat-docs/redhat-docs-pdf-template):/pdf-assets ./pdf-assets

# Build PDF output
podman run --rm -it -v "$(pwd)":/docs:Z quay.io/redhat-docs/redhat-docs-pdf-template main.adoc
```

This generates `main.pdf` in the current directory.

## Automated Publishing

GitHub Actions automatically handle publishing on commits to the `main` branch:

- **deploy-site.yml**: Builds HTML and deploys to GitHub Pages
- **publish-pdf.yml**: Builds PDF and creates a new GitHub release with version `v2.0.<run_number>`

Wait for workflow actions to complete before manually editing release notes or version tags.

## Helper Scripts

Located in `scripts/`:

- **add_asciidoc_ids.py**: Generates `[id="..."]` attributes for section headings based on the `cnf-best-practices-` prefix and title
- **split_asciidoc.py**: Splits a monolithic AsciiDoc file into separate module files based on `[id="..."]` markers

## Contributing Guidelines

### Content Guidelines
- Each module should have a unique `[id="cnf-best-practices-<topic>"]` anchor at the top
- Section IDs should follow the pattern: `cnf-best-practices-<lowercase-hyphenated-title>`
- New modules must be added to `main.adoc` with appropriate `leveloffset` for hierarchy

### Module Hierarchy
The `leveloffset` parameter in `main.adoc` includes controls the heading level:
- `leveloffset=+1`: Top-level section
- `leveloffset=+2`: Subsection
- `leveloffset=+3`, `+4`, `+5`: Deeper nesting levels

### Pull Request Process
- Commits are subject to PR review and approval by the CNF Best Practices team
- New releases, GitHub Pages deployments, and PDF versions are triggered automatically upon merge to `main`

## File Organization

```
guide/
├── main.adoc              # Main assembly file (entry point)
├── modules/               # Individual documentation modules (80+ files)
│   ├── cnf-best-practices-foreword.adoc
│   ├── cnf-best-practices-openshift-platform.adoc
│   ├── cnf-best-practices-developer-guide.adoc
│   └── ...
├── scripts/               # Helper Python scripts
│   ├── add_asciidoc_ids.py
│   └── split_asciidoc.py
├── .github/
│   ├── workflows/
│   │   ├── deploy-site.yml    # HTML deployment workflow
│   │   └── publish-pdf.yml    # PDF release workflow
│   └── dependabot.yml
├── LICENCE                # CC BY 4.0 license
└── README.md
```

## Generated Files (gitignored)

The following are generated during builds and should not be committed:
- `index.html` - Generated HTML output
- `main.pdf` / `cnf-best-practices.pdf` - Generated PDF output
- `assets/` - Extracted from HTML template container
- `pdf-assets/` - Extracted from PDF template container

## License

This documentation is licensed under Creative Commons Attribution 4.0 International (CC BY 4.0), copyright Red Hat Inc. and Verizon.
