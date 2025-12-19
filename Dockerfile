# syntax=docker/dockerfile:1
# check=error=true

# Dockerfile para produção Rails + Sidekiq

ARG RUBY_VERSION=3.2.3
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# --------------------
# 1️⃣ Diretório da aplicação
# --------------------
WORKDIR /rails

# --------------------
# 2️⃣ Instalar pacotes básicos
# --------------------
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        curl libjemalloc2 libvips sqlite3 && \
    ln -s /usr/lib/$(uname -m)-linux-gnu/libjemalloc.so.2 /usr/local/lib/libjemalloc.so && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# --------------------
# 3️⃣ Variáveis de ambiente para produção
# --------------------
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    LD_PRELOAD="/usr/local/lib/libjemalloc.so"

# --------------------
# 4️⃣ Build stage para instalar gems
# --------------------
FROM base AS build

# Instalar pacotes necessários para compilar gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copiar Gemfile e instalar gems
COPY Gemfile Gemfile.lock vendor ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile -j 1 --gemfile

# Copiar código da aplicação
COPY . .

# Precompilar bootsnap e assets
RUN bundle exec bootsnap precompile -j 1 app/ lib/
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# --------------------
# 5️⃣ Stage final
# --------------------
FROM base

# Criar usuário não-root e pastas com permissão correta
RUN groupadd --system --gid 1000 rails && \
    useradd --system --uid 1000 --gid 1000 --create-home --shell /bin/bash rails && \
    mkdir -p /rails/storage/emails && chown -R rails:rails /rails/storage

# Trocar para usuário rails
USER 1000:1000

# Copiar artifacts do build
COPY --chown=rails:rails --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --chown=rails:rails --from=build /rails /rails

# Entrypoint e comando padrão
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
EXPOSE 80
CMD ["./bin/thrust", "./bin/rails", "server", "-b", "0.0.0.0"]
