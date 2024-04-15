FROM ubuntu:jammy

LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
      org.opencontainers.image.source="https://github.com/LDSamson/rocker-versioned2" \
      org.opencontainers.image.vendor="Rocker Project" \
      org.opencontainers.image.authors="Carl Boettiger <cboettig@ropensci.org>"

ENV R_VERSION=4.3.2
ENV R_HOME=/usr/local/lib/R
ENV TZ=Etc/UTC

COPY scripts/install_R_source.sh /rocker_scripts/install_R_source.sh

RUN /rocker_scripts/install_R_source.sh

ENV CRAN=https://p3m.dev/cran/__linux__/jammy/2024-02-28
ENV LANG=en_US.UTF-8

COPY scripts /rocker_scripts

RUN /rocker_scripts/setup_R.sh

ENV PANDOC_VERSION=default
ENV QUARTO_VERSION=default

RUN /rocker_scripts/install_pandoc.sh

ENV CTAN_REPO=https://www.texlive.info/tlnet-archive/2023/10/30/tlnet
ENV PATH=$PATH:/usr/local/texlive/bin/linux

RUN /rocker_scripts/install_texlive.sh

# packages below are needed to run base R tests successfully
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata tk-dev
RUN tlmgr install colortbl booktabs fancyhdr caption grfext

CMD ["R"]
