class HttpExc implements Exception {
  final String message;

  HttpExc(this.message);

  @override
  String toString() {
    return message;
  }
}
