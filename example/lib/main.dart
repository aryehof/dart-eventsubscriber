import 'dart:io';

import 'package:flutter/material.dart';
import 'package:eventsubscriber/eventsubscriber.dart';
import 'package:event/event.dart';

import 'counter.dart';

// Create the domain model
var myCounter = Counter();

// ==========================================

// Flutter application
// The myCounter.value will increment when the button is pressed.
// The changed domain value will be automatically updated in the UI.

void main() {
  // Optional diagnostic logging
  showLog(stdout, Severity.all);
  log("Starting example Counter app"); // an example log message

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("EventSubscriber Example"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //=================================
              // Subscribe to the 'valueChangedEvent' domain event
              // The handler will be run whenever the Event occurs (is broadcast)
              EventSubscriber(
                events: [myCounter.valueChangedEvent], // can subscribe to more than 1 Event
                builder: (context, status, args) {
                  // status is new in 3.0
                  return Column(
                    children: [
                      Text('Counter: ${myCounter.value}', style: TextStyle(fontSize: 24)),

                      // do something different if no events received yet
                      if (status.hasReceivedFirstEvent)
                        Column(
                          children: [
                            SizedBox(height: 24),
                            //
                            Text('Received Event'),
                            Text('When: ${args.whenOccurred}'),
                            Text('Event count: ${status.numEventsReceived}'),
                            Text('Event name: ${args.eventName}'),
                            //
                            SizedBox(height: 24),
                            Text('Note: See the Flutter DevTools Logging pane'),
                            Text('for diagnostic Event related messages.'),
                          ],
                        )
                      else
                        Text('No event received yet'),
                    ],
                  );
                },
              ),

              //=================================
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: myCounter.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
