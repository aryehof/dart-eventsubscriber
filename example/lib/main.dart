import 'package:flutter/material.dart';
import 'package:eventsubscriber/eventsubscriber.dart';

import 'counter.dart';

// Create the domain model
var myCounter = Count();

// ==========================================

// Flutter application
// The Count domain value will increment when the button is pressed.
// The updated domain value will be automatically updated in the UI.

void main() {
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
              // The handler will be run whenever the Event occurs
              EventSubscriber(
                event: myCounter.valueChangedEvent,
                builder: (context, args) => Text(
                  'Counter: ${myCounter.value}',
                  style: Theme.of(context).textTheme.headline3,
                ),
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
