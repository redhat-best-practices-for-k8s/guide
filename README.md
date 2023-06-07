This document provides guidance and information for developing OpenShift applications in compliance with commonly recognized industry standards and best practices for Cloud Native Functions (CNFs).

The entrypoint to this document is the `main.adoc` assembly file.

To build the HTML, install `podman`, and then:

```cmd
podman pull quay.io/redhat-docs/redhat-docs-template
podman cp $(podman run --detach quay.io/redhat-docs/redhat-docs-template):/assets ./assets
podman run --rm -it -v "$(pwd)":/docs:Z quay.io/redhat-docs/redhat-docs-template main.adoc
```

To build the PDF:

```cmd
podman pull quay.io/redhat-docs/redhat-docs-pdf-template
podman cp $(podman run --detach quay.io/redhat-docs/redhat-docs-pdf-template):/pdf-assets ./pdf-assets
podman run --rm -it -v "$(pwd)":/docs:Z quay.io/redhat-docs/redhat-docs-pdf-template main.adoc
```
