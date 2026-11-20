FROM folioci/alpine-jre-openjdk21:latest

# Install latest patch versions of packages: https://pythonspeed.com/articles/security-updates-in-docker/
USER root
RUN apk upgrade --no-cache
USER folio

# Java4Shell (CVE-2026-114938) mitigation: disable the vulnerable AVX-512 Base64
# intrinsic until the base image ships OpenJDK >= 21.0.13.1. Remove afterwards.
ENV JDK_JAVA_OPTIONS="-XX:-UseBASE64Intrinsics"

ENV VERTICLE_FILE edge-sip2-fat.jar

# Set the location of the verticles
ENV VERTICLE_HOME /usr/verticles

# Copy your fat jar to the container
COPY target/${VERTICLE_FILE} ${VERTICLE_HOME}/${VERTICLE_FILE}

# Expose this port locally in the container.
EXPOSE 6443
