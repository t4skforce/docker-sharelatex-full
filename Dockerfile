FROM sharelatex/sharelatex

ARG BUILD_DATE=""

# Upgrade System
RUN set -x \
    && apt-get update \
    && apt-get  upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# Install TeX Live: metapackage pulling in all components of TeX Live
RUN set -x \
    && apt-get update \
    && apt-get install -y texlive-full \
    && rm -rf /var/lib/apt/lists/*

# Install Pygments for minted
RUN set -x \
    && apt-get update \
    && apt-get install -y xzdec python-pygments \
    && rm -rf /var/lib/apt/lists/*

# Install all spellchecking languages
RUN set -x \
    && apt-get update \
    && apt-get install -y aspell aspell-* \
    && rm -rf /var/lib/apt/lists/*

# -shell-escape is required by minted
# https://github.com/sharelatex/sharelatex-docker-image/issues/45#issuecomment-247809588
RUN set -x \
    && sed -i 's/concat(\[\"-pdf\",/concat(\[\"-pdf\",\"-shell-escape\",/g' /var/www/sharelatex/clsi/app/js/LatexRunner.js
    
# workaround https://github.com/overleaf/overleaf/issues/767
RUN set -x \
    && cd /var/www/sharelatex/web/ && npm install i18next-fs-backend
