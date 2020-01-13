# EventSubscriber

[![Pub Package](https://img.shields.io/pub/v/eventsubscriber.svg?style=flat-square)](https://pub.dev/packages/eventsubscriber)

A Flutter widget that supports subscribing to one or more named [EventNotifier][eventnotifier] events.

 The `EventSubscriber` widget will be notified and rebuilt when a subscribed event occurs, allowing some changing aspect of a problem domain model to be displayed in your Flutter user interface.

## See also

[EventNotifier][eventnotifier] - broadcasts named events to interested subscribers.

## Dependencies

- `Flutter` - This Dart package has a dependency on the `Flutter` framework.

## Usage

A simple example:

```dart
import 'package:flutter/material.dart';
import 'package:eventnotifier/eventnotifier.dart';
import 'package:eventsubscriber/eventsubscriber.dart';

// An example domain model
// Normally in its own module/package
// Included here for illustration purposes
class Count with EventNotifier {
  int value = 0;
  void increment() {
    value++;
    notify('valueChanged'); // notify subscribers
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
            EventSubscriber(      // <<===
                model: myCount,
                eventNames: ['valueChanged'],
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

[tracker]: https://github.com/aryehof/eventsubscriber/issues
[eventnotifier]: https://pub.dev/packages/eventnotifier
