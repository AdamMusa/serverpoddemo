# Serverpod bootstrap

This repository was created with the official Serverpod CLI and retains its
generated server, client, and Flutter packages:

```sh
dart pub global activate serverpod_cli 3.4.11
serverpod create serverpoddemo
cd serverpoddemo/serverpoddemo_flutter
flutter create . --platforms web
```

The production Flutter client is built with:

```sh
flutter build web --release --base-href /app/ --wasm \
  --dart-define=SERVER_URL=https://serverpod-api.alkimist.dev/
```

Serverpod serves that build at `/app`; Alkimist routes the generated API role
through `serverpod-api.alkimist.dev`.
