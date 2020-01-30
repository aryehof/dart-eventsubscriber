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
              onPressed: () => myCount.increment(),
            )
          ],
        ),
      ),
    );
