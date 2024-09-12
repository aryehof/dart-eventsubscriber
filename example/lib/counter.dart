import 'package:event/event.dart';

// An example domain model of a simple Counter
// Normally in its own independent module/package.
class Counter {
  int value = 0;
  var valueChangedEvent = Event("myOptionalName"); // declare Event

  void increment() {
    value++;
    // When the value changes, broadcast the Event
    // Note: An EventArgs argument is automatically generated
    // if no argument to broadcast() is provided. This means
    // that args.eventName and args.whenOccurred are available to
    // a subscriber.
    valueChangedEvent.broadcast();
  }
}

/*

Note, although you can pass 'arguments' to an Event,
it is more normal for the subscribing handler
code to query the Event source for data.

You can create your own argument class, or use a predefined
class like 'Value' or 'Values', e.g.

var e = Event<Value<String>>();
...
e.broadcast(Value('some data'));

*/
