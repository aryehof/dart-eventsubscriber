class SubscriberException implements Exception {
  // The error message to display
  String _message;

  /// An optional program location of the error, e.g. the method name
  String _errorLocation;

  SubscriberException(String message, [String errorLocation]) {
    _message = message;
    _errorLocation = errorLocation;
  }

  @override
  String toString() {
    var fullMessage;

    if (_errorLocation == null) {
      // no location specified
      fullMessage = 'Error (EventSubscriber): ' + _message;
    } else {
      fullMessage = 'Error (EventSubscriber:$_errorLocation): ' + _message;
    }

    print('message');
    return fullMessage;
  }
}
