FROM rust:1.71-bullseye as builder
WORKDIR /usr/src/freighter
COPY . .
RUN cd freighter && cargo install --path .

FROM debian:bullseye-slim
COPY --from=builder /usr/local/cargo/bin/freighter /usr/local/bin/freighter

USER nobody:nogroup

CMD ["freighter", "-c", "config.yaml"]
