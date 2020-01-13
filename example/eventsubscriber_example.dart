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
            EventSubscriber(
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
