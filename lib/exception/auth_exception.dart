class AuthExpection implements Exception {
  final message;
  AuthExpection(this.message);

  @override
  String toString() {
    return message;
  }
}
