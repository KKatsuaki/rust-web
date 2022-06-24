FROM rust:latest

RUN apt update && apt install curl build-essential default-libmysqlclient-dev openssl default-mysql-client zsh -y

RUN rustup default nightly
RUN cargo install diesel_cli cargo-edit
COPY ./docker/rust/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
COPY ./docker/rust/zshrc /etc/zsh/zshrc

WORKDIR /accounting-server

ENTRYPOINT "/tmp/entrypoint.sh"
