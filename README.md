# EventSubscriber

[![Pub Package](https://img.shields.io/pub/v/eventsubscriber.svg?style=flat-square)](https://pub.dev/packages/eventsubscriber)

A Flutter widget that supports subscribing to an [Event].

 The `EventSubscriber` widget will be notified and rebuilt when the [Event] occurs, allowing some changing aspect of an observed object to be displayed in your Flutter user interface.

 Note: run the included Example project to see a working example.

---

### Contents
- [Usage](#usage)
- [See also](#seealso)
- [Dependencies](#dependencies)
- [Examples](#example)
  - [Simple Example](#simple-example)
  - [Using Arguments (EventArgs)](#using-arguments)
- [Requesting Features and Reporting Bugs](#features-and-bugs)

---

 ## [Usage](#usage)

 The Flutter `EventSubscriber` Widget requires that the `Event` being subscribed to is specified, along with a `builder` (`handler`) that returns a child Widget.

```dart
// example ...
EventSubscriber(
  event: myCount.valueChangedEvent,
  builder: (context, args) => Text('${myCount.value}'),
),
```

## [See Also](#seealso)

[Event] - A Dart package that broadcasts events to interested subscribers.

## [Dependencies](#dependencies)

- [Flutter][flutter] - This Dart package has a dependency on the `Flutter` framework.
- [Event] - Supports the creation of lightweight custom Dart Events, that allow interested subscribers to be notified that something has happened. Provides a notification mechanism across independent packages/layers/modules.

## [Examples](#examples)

#### [Simple Example](#simple-example)

```dart
import 'package:flutter/material.dart';
import 'package:event/event.dart';
import 'package:eventsubscriber/eventsubscriber.dart';

// An example domain model of a simple Counter
// Normally in its own module/package
// Included here inline for illustration purposes
class Count {
  int value = 0;
  var valueChangedEvent = Event(); // declare Event

  void increment() {
    value++;
    // Broadcast that the value has changed
    valueChangedEvent.broadcast();
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
              event: myCount.valueChangedEvent,
              builder: (context, args) => Text(myCount.value.toString()),
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

### [Using Arguments (EventArgs)](#using-arguments)

One might alter the above `Count` domain model to include custom arguments (`EventArgs`). In other words, to pass data with the 'Event'. For example, we might want to provide the subscriber handler with the date and time the event occured, and also if the counter value is an even number (divisible by 2).

> See the [Event] package for additional information about [EventArgs].

```dart

// Example custom Event arguments
ValueChangedEventArgs extends EventArgs {
  DateTime whenOccured;
  bool isEven;
  // constructor
  valueChangedEvent(int value) {
    whenOccured = DateTime.now();
    isEven = (myValue % 2) == 0;  // even number?
  }
}

```
To use `ValueChangedEventArgs`, one would alter the `Counter` class from the previous simple example as follows:-

```dart
// Includes Event arguments
class Count {
  int value = 0;
  var valueChangedEvent = Event<ValueChangedEventArgs>(); //<<====

  void increment() {
    value++;
    // Broadcast that the value has changed
    valueChangedEvent.broadcast(ValueChangedEventArgs(value)); //<<====
  }
}
```

In Flutter, the arguments can be used as follows.

> _Note that best practice is that generally on notification one queries the domain model directly, rather than having arguments deliver data to a consumer of the domain model, i.e. this Flutter UI application. The supply of data shown here is by way of example only._

```dart
// In Flutter use the passed data...

EventSubscriber(
  event: myCount.valueChangedEvent,
  builder: (context, args) {
    // Display the counter value, as well as whether
    // the counter value is even.
    
    return Text('${myCount.value} ${args?.isEven}');

    // Note that we must check if args is null. The
    // flutter framework will also call this handler in
    // which case args will be null.
),
```

## [Requesting Features and Reporting Bugs](#Features-and-bugs)

Please enter feature requests and report bugs at the [issue tracker][tracker].

[tracker]: https://github.com/aryehof/dart-eventsubscriber/issues
[eventnotifier]: https://pub.dev/packages/eventnotifier
[flutter]: https://flutter.dev/
[event]: https://pub.dev/packages/event
