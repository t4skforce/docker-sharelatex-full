FROM sharelatex/sharelatex

# This must be before install texlive-full
RUN set -x \
    && apt-get update \
    && apt-get install -y p7zip-full p7zip-rar \
    && tlmgr init-usertree \
    # Select closest mirror automatically: http://tug.org/texlive/doc/install-tl.html
    #
    && export TEXLIVE_YEAR=$(cd /usr/local/texlive ; ls -d * | egrep '[0-9]+') \
    && (cd /tmp/; curl -o texlive.iso -L ftp://tug.org/historic/systems/texlive/${TEXLIVE_YEAR}/texlive.iso) \
    && 7z x -bd -y -w/tmp/ /tmp/texlive.iso \
    && tlmgr option repository /tmp/ \
    # Latest TeX Live repository for 2019
    #
    && tlmgr --verify-repo=none update --self \
    # upgrade
    #
    && tlmgr --verify-repo=none install scheme-full \
    # https://tex.stackexchange.com/questions/340964/what-do-i-need-to-install-to-make-more-packages-available-under-sharelatex
    #
    && luaotfload-tool -fu \
    # Remake the lualatex/fontspec cache:
    #
    && apt-get purge -y p7zip-full p7zip-rar \
    && rm -rf /usr/local/texlive/*/tlpkg/backups/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

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
