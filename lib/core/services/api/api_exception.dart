class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => message;
}

class GenericException extends ApiException {
  GenericException([String? message]) : super(message ?? 'An error occured!');
}

class NetworkException extends ApiException {
  NetworkException([String? message])
      : super(message ?? 'No internet connection');
}

class NullException extends ApiException {
  NullException([String? message]) : super(message ?? 'No data found');
}

class EmptyFavouritesException extends ApiException {
  EmptyFavouritesException([String? message])
      : super(message ?? 'You have no favourites at this time.');
}
