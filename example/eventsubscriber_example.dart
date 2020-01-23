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
