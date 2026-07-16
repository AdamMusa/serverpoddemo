FROM dart:3.8.0 AS build
WORKDIR /app

COPY pubspec.* ./
RUN dart pub get
COPY . .
RUN dart compile exe bin/main.dart -o /app/server
RUN mkdir -p config web migrations lib/src/generated

FROM alpine:latest
WORKDIR /app
COPY --from=build /runtime/ /
COPY --from=build /app/server /app/server
COPY --from=build /app/config/ config/
COPY --from=build /app/web/ web/
COPY --from=build /app/migrations/ migrations/
COPY --from=build /app/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml
EXPOSE 8080 8081 8082
ENTRYPOINT ["/app/server"]
CMD ["--mode=production", "--server-id=default", "--logging=normal", "--role=monolith", "--apply-migrations"]
