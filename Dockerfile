FROM rocker/rstudio:3.6.3-ubuntu18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -yqq \
    git \
    jq \
    libnetcdf-dev \
    libpng-dev \
    libssl-dev \
    libxml2-dev \
    make \
    curl \
    build-essential \
    libbz2-dev \
    libffi-dev \
    libgdbm-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libnss3-dev \
    libreadline-dev \
    libsqlite3-dev \
    xz-utils \
    zlib1g-dev \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



ENV HOME  /
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
ENV PYTHON_CONFIGURE_OPTS="--enable-shared"

# install pyenv & python & pip & pipenv
RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash \
 && pyenv install 3.10.3 \
 && pyenv global 3.10.3
RUN pip install --upgrade pip \
 && pip install pipenv


RUN wget https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-1-amd64.deb && \
    dpkg -i pandoc-2.19.2-1-amd64.deb && \
    rm pandoc-2.19.2-1-amd64.deb

RUN install2.r --error \
    renv

COPY renv.lock renv.lock

RUN Rscript -e "renv::restore()"


EXPOSE 8787

CMD ["/init"]
