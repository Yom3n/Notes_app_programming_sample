class NoteRestServiceException extends Error {
  final int statusCode;
  final String errorMessage;

  NoteRestServiceException({
    required this.statusCode,
    this.errorMessage = '',
  });

  @override
  String toString() {
    return 'Status code: $statusCode \n$errorMessage';
  }
}
