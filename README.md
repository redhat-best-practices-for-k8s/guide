This document provides guidance and information for developing OpenShift applications in compliance with commonly recognized industry standards and best practices for Cloud Native Functions (CNFs).

New releases, Github page deployments (HTML versions), PDF versions are triggered automatically upon commit to the main branch. 

It is therefore recommended to wait for the workflow actions (https://github.com/test-network-function/cnf-best-practices/actions) to finish and auto generate a new release with the latest commits, then edit the release notes and version tag manually if so desired.

The latest release will be auto published (via Github-page bot) to https://test-network-function.github.io/cnf-best-practices/

The latest (and previous) PDF versions can be downloadeded from: https://github.com/test-network-function/cnf-best-practices/releases


For contributors:

Commits will be subjected to PR review and approval by the CNF Best Practices team.
Owners of other private repos will be responsible for the review, approval, and maintenance of the content in their respective repos.



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
