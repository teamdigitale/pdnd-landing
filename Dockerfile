FROM jekyll/jekyll:3.8.6 AS builder

COPY . .
RUN bundle install
RUN jekyll build -d /tmp/jekyll/site

FROM nginx:1.16.1
LABEL maintainer="https://teamdigitale.governo.it"

# Install major CA certificates to cover
# https://github.com/SparebankenVest/azure-key-vault-to-kubernetes integration
RUN apt-get update && \
    apt-get install -y ca-certificates

COPY --from=builder /tmp/jekyll/site /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
