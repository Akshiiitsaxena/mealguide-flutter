class MgException implements Exception {
  final String? message;
  final int? code;

  MgException({this.message, this.code});
}
