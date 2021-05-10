import 'package:event/event.dart';

// An example domain model of a simple Counter
// Normally in its own module/package
class Count {
  int value = 0;
  var valueChangedEvent = Event(); // declare Event

  void increment() {
    value++;
    // When the value changes, broadcast the Event
    valueChangedEvent.broadcast();
  }
}

/*

Note, that you can pass 'arguments' to an Event,
although it is more normal for the subscribing handler
code to query the Event source for data.

You can create your own argument class, or use a predefined
class like 'Value' or 'Values', e.g.

var valueChangedEvent = Event(Value<String>);
...
valueChangedEvent.broadcast(Value('some data'));

*/
