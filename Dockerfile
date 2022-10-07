ARG BUILD_DATE="2022-10-07T08:59:06Z"
ARG VERSION="3.2.2"

FROM sharelatex/sharelatex:${VERSION}

RUN set -xe \
    && apt-get update -qqy || apt-get --only-upgrade install ca-certificates -y && apt-get update -qqy \
    && apt-get  upgrade -y \
    && apt-get install -y texlive-full xzdec python-pygments aspell aspell-* \
    && rm -rf /var/lib/apt/lists/*

# Basic build-time metadata as defined at http://label-schema.org
LABEL org.label-schema.schema-version=1.0 \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="AGPL-3.0 License" \
    org.label-schema.name="docker-sharelatex-full" \
    org.label-schema.vendor="t4skforce" \
    org.label-schema.version="Overleaf v${VERSION}" \
    org.label-schema.description="An open-source online real-time collaborative LaTeX editor." \
    org.label-schema.url="https://github.com/t4skforce/docker-sharelatex-full" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/t4skforce/docker-sharelatex-full.git" \
    maintainer="t4skforce" \
    Author="t4skforce"
