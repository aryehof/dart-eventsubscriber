# EventSubscriber

[![Pub Package](https://img.shields.io/pub/v/eventsubscriber.svg?style=flat-square)](https://pub.dev/packages/eventsubscriber)

A Flutter widget that supports subscribing to an [Event].

 The `EventSubscriber` widget will be notified and rebuilt when the [Event] occurs, allowing some changing aspect of an observed object to be displayed in your Flutter user interface.

## See also

[Event] - broadcasts events to interested subscribers.

## Dependencies

- [Flutter][flutter] - This Dart package has a dependency on the `Flutter` framework.
- [Event] - Supports the creation of lightweight custom Dart Events, that allow interested subscribers to be notified that something has happened. Provides a notification mechanism across independent packages/layers/modules.

## Usage

A simple example:

```dart
import 'package:flutter/material.dart';
import 'package:event/event.dart';
import 'package:eventsubscriber/eventsubscriber.dart';

// An example domain model of a simple Counter
// Normally in its own module/package
// Included here inline for illustration purposes
class Count {
  int value = 0;
  var onValueChanged = Event(); // declare Event

  void increment() {
    value++;
    // Broadcast that the value has changed
    onValueChanged.broadcast();
  }
}

//////////////////////

// Create the domain model
var myCount = Count();

// Flutter application
// The Count domain value will increment when the button is pressed.
// The updated domain value will be automatically updated in the UI.
void main() => runApp(
      MaterialApp(
        home: Column(
          children: <Widget>[
            // Subscribe to the 'valueChanged' domain event
            EventSubscriber(
              event: myCount.onValueChanged,
              builder: (context) => Text(myCount.value.toString()),
            ),
            FlatButton(
              child: Text('Increment'),
              // Increment the domain value
              onPressed: () => myCount.increment(),
            )
          ],
        ),
      ),
    );

```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/aryehof/dart-eventsubscriber/issues
[eventnotifier]: https://pub.dev/packages/eventnotifier
[flutter]: https://flutter.dev/
[event]: https://pub.dev/packages/event
