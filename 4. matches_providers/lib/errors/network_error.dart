class NetworkError extends Error {
  final int statusCode;
  final String? reasonPhrase;

  NetworkError(this.statusCode, this.reasonPhrase);
}
