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

// An example domain model
// Normally in its own module/package
// Included here for illustration purposes
class Count {
  int value = 0;
  var onValueChanged = Event();

  void increment() {
    value++;
    onValueChanged.raise();
  }
}

//////////////////////

// Create the domain model
var myCount = Count();

// Flutter application
void main() => runApp(
      MaterialApp(
        home: Column(
          children: <Widget>[
            // Subscribe to the 'valueChanged' model event
            EventSubscriber(
              event: myCount.onValueChanged,
              builder: (context) => Text(myCount.value.toString()),
            ),
            FlatButton(
              child: Text('Increment'),
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
