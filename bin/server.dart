import "dart:io";

Future<void> main(List<String> args) async {
  final port = int.tryParse(Platform.environment["PORT"] ?? "") ?? 8080;
  final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
  await for (final request in server) {
    request.response.headers.contentType = ContentType.text;
    if (request.uri.path == "/up") {
      request.response.write("ok");
    } else {
      request.response.write("Serverpod on Alkimist");
    }
    await request.response.close();
  }
}
