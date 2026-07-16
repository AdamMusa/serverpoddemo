FROM dart:3.8.0 AS build
WORKDIR /workspace
COPY . .
RUN sed -i '/_flutter$/d' /workspace/pubspec.yaml
WORKDIR /workspace/serverpoddemo_server
RUN dart pub get
RUN mkdir -p /app && dart compile exe bin/main.dart -o /app/server
RUN mkdir -p config web migrations lib/src/generated

FROM alpine:latest
WORKDIR /app
COPY --from=build /runtime/ /
COPY --from=build /app/server /app/server
COPY --from=build /workspace/serverpoddemo_server/config/ config/
COPY --from=build /workspace/serverpoddemo_server/web/ web/
COPY --from=build /workspace/serverpoddemo_server/migrations/ migrations/
COPY --from=build /workspace/serverpoddemo_server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml
EXPOSE 8080 8081 8082
ENTRYPOINT ["/app/server"]
CMD ["--mode=production", "--server-id=default", "--logging=normal", "--role=monolith", "--apply-migrations"]
