FROM sharelatex/sharelatex

# This must be before install texlive-full
RUN set -x \
    && tlmgr init-usertree \
    # Select closest mirror automatically: http://tug.org/texlive/doc/install-tl.html
    #
    && tlmgr --verify-repo=none update --self \
    # https://tex.stackexchange.com/questions/340964/what-do-i-need-to-install-to-make-more-packages-available-under-sharelatex
    && tlmgr install scheme-full

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
RUN sed -i 's/concat(\[\"-pdf\",/concat(\[\"-pdf\",\"-shell-escape\",/g' /var/www/sharelatex/clsi/app/js/LatexRunner.js
