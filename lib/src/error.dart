// Copyright 2020 Aryeh Hoffman. All rights reserved.
// Use of this source code is governed by an Apache-2.0 license that can be
// found in the LICENSE file.

class SubscriberError extends Error {
  /// The error message to display
  String _message;

  /// An optional program location of the error, e.g. the method name
  String _errorLocation;

  /// Creates a [SubscriberError] with the specified message and
  /// (optional) location.
  SubscriberError(String message, [String errorLocation]) {
    _message = message;
    _errorLocation = errorLocation;
  }

  @override
  String toString() {
    return (_errorLocation == null
            ? 'Error (EventSubscriber): '
            : 'Error (EventSubscriber:$_errorLocation): ') +
        _message;
  }
}
