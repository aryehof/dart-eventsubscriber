// Copyright 2020 Aryeh Hoffman. All rights reserved.
// Use of this source code is governed by an Apache-2.0 license that can be
// found in the LICENSE file.

import 'package:event/event.dart';
import 'package:eventsubscriber/src/eventstatus.dart';
import 'package:flutter/material.dart';

/// A function definition that returns a Widget, given a context,
/// [EventStatus], and [EventArgs] or [EventArgs] derived object.
typedef EventFunc<T extends EventArgs> = Widget Function(
    BuildContext context, EventStatus status, T args);

///////////////

/// Represents a [Widget] that supports subscribing to an [Event],
/// that updates (rebuilds) when the [Event] occurs.
///
/// See [Event] at https://pub.dev/packages/event
class EventSubscriber<T extends EventArgs> extends StatefulWidget {
  /// A `List` of one or more [Event]'s to subscribe to. When an Event occurs,
  /// this [EventSubscriber] will update (rebuild).
  ///
  /// ```dart
  /// // example
  /// events: [[myCount.onValueChanged]]
  /// ```
  late List<Event<T>> events = [];

  /// A function ([EventFunc]) that returns a Widget.
  ///
  /// Typically the returned [Widget] (or a descendant)
  /// will reference some aspect of the object containing the observed [Event].
  ///
  /// ```dart
  /// // example
  /// builder: (context, status, args) => Text(myCount.value.toString())
  /// ```
  final EventFunc<T> builder;

  // Constructor
  /// Creates an [EventSubscriber], a Widget that rebuilds when an [Event] occurs.
  /// Requires a list of Events, and a [builder]. A builder is a function that returns
  /// a Widget that is given a [BuildContext], [EventStatus] and [EventArgs].
  ///
  /// ```dart
  /// // example
  /// EventSubscriber(
  ///   events: [[counter.changed]], // list of one or more Events
  ///   builder: (context, status, args) {
  ///     return Placeholder();
  ///   }
  /// )
  /// ```
  ///
  /// Query the object that defined the Event (if appropriate) to determine details
  /// of what changed, or provide data as Event arguments.
  EventSubscriber({required this.events, required this.builder, super.key});

  @override
  EventSubscriberState<T> createState() => EventSubscriberState<T>();
}

///////////////

class EventSubscriberState<T extends EventArgs> extends State<EventSubscriber<T>> {
  /// [Event] arguments provided when an [Event] is broadcast.
  T _eventArgs = EventArgs() as T;
  final _status = EventStatus();

  /// The handler that will be subscribed to this Widget's
  /// associated [Event]. Causes your handler to be called, and
  /// the widget to rebuild.
  void _eventHandler(T args) {
    setState(() {
      this._eventArgs = args;
      _status.numEventsReceived++;

      log('Event received so widget rebuilt (#${_status.numEventsReceived}) "${_eventArgs.eventName ?? "Unnamed"}"',
          source: "EventSubscriber", level: Severity.debug);
    });
  }

  @override
  void initState() {
    super.initState();
    // subscribe the handler to each Event
    for (var event in widget.events) {
      event.subscribe(_eventHandler);
    }
  }

  @override
  void dispose() {
    for (var event in widget.events) {
      event.unsubscribe(_eventHandler);
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(EventSubscriber oldWidget) {
    super.didUpdateWidget(oldWidget as EventSubscriber<T>);
    if (widget.events != oldWidget.events) {
      // remove subscribers from oldWidget
      for (var oldEvent in oldWidget.events) {
        oldEvent.unsubscribe(_eventHandler);
      }
      // add subscribers in new widget
      for (var event in widget.events) {
        event.subscribe(_eventHandler);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _status, _eventArgs);
  }
}
