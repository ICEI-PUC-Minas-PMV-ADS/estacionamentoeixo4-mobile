class CustomHttpResponse {
  CustomHttpResponse(
    this.body, [
    this.statusCode,
    this.statusMessage,
  ]);

  dynamic body;

  int? statusCode;

  String? statusMessage;
}
