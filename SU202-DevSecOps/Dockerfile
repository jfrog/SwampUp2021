ARG BASE_IMAGE=foo
FROM ${BASE_IMAGE}
LABEL maintainer="jeromep@jfrog.com" description="Swampup DevSecOps sample image"

USER foo:bar

# adding gradle archive
ADD build/distributions/*.tar dist
