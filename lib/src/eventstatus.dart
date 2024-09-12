// Copyright 2020 Aryeh Hoffman. All rights reserved.
// Use of this source code is governed by an Apache-2.0 license that can be
// found in the LICENSE file.

/// Provides Event related status information.
/// See the EventSubscriber 'builder' constructor argument
/// which includes an EventStatus.
class EventStatus {
  /// The total number of an associated Event received.
  int numEventsReceived = 0;

  /// Indicates that a first Event has been received.
  /// An alternative to querying if `numEventsReceived > 0`.
  bool get hasReceivedFirstEvent {
    return numEventsReceived > 0;
  }
}
