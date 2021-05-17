# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.158.0/containers/ruby/.devcontainer/base.Dockerfile

# [Choice] Ruby version: 3, 3.0, 2, 2.7, 2.6, 2.5
ARG VARIANT="3"
FROM mcr.microsoft.com/vscode/devcontainers/ruby:0-${VARIANT}

# Install node
ARG INSTALL_NODE="false"
ARG NODE_VERSION="lts/*"
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# Install additional OS packages
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
  apt-get update && export DEBIAN_FRONTEND=noninteractive && \
  apt-get -y install --no-install-recommends \
  apt-utils \
  sudo \
  git \
  procps \
  lsb-release \
  curl \
  unzip \
  gnupg \
  bash-completion \
  python3-pip \
  keychain \
  jq \
  xz-utils \
  apt-transport-https \
  ca-certificates \
  gnupg-agent \
  software-properties-common \
  vim \
  google-cloud-sdk \
  python3-google-auth \
  2>&1

# Install Python libraries
RUN pip3 install --upgrade \
  pre-commit \
  detect-secrets==0.14.3 \
  google-api-python-client

# mkdocs mkdocs-material mkdocs-minify-plugin

# Install Ruby libraries
RUN gem install \
  kitchen-terraform:5.7 \
  yaml:0.1.1

# Install terraform
ENV TERRAFORM_VERSION=0.13.6
RUN curl -SL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
  rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install terraform-docs
ENV TERRAFORM_DOCS_VERSION=0.11.2
RUN curl -SL https://github.com/terraform-docs/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-$(uname)-amd64.tar.gz > terraform-docs.tar.xz && \
  tar xzf terraform-docs.tar.xz -C /bin && \
  rm -f terraform-docs.tar.xz

# Install shellcheck
ENV SHELLCHECK_VERSION=0.7.1
RUN curl -SL https://github.com/koalaman/shellcheck/releases/download/v${SHELLCHECK_VERSION}/shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.xz > shellcheck.tar.xz && \
  tar xJf shellcheck.tar.xz && \
  mv shellcheck-v${SHELLCHECK_VERSION}/shellcheck /bin && \
  rm -rf shellcheck*

# Install global node packages
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && \
  npm install -g \
  markdownlint-cli \
  " 2>&1

# Suppress GCP quota warning
ENV GOOGLE_AUTH_SUPPRESS_CREDENTIALS_WARNINGS=1
