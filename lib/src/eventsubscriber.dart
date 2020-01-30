// Copyright 2020 Aryeh Hoffman. All rights reserved.
// Use of this source code is governed by an Apache-2.0 license that can be
// found in the LICENSE file.

import 'package:event/event.dart';
import 'package:flutter/material.dart';

import 'package:eventsubscriber/src/error.dart';

/// Represents a [Widget] that supports subscribing to an [Event],
/// that updates (rebuilds) when the [Event] occurs.
///
/// See [Event] at https://pub.dev/packages/event
class EventSubscriber extends StatefulWidget {
  /// The [Event] to subscribe to, that will cause
  ///  this [EventSubscriber] to update (rebuild).
  ///
  /// ```dart
  /// // example
  /// event: myCount.onValueChanged
  /// ```
  final Event<EventArgs> event;

  /// A function ([WidgetBuilder]) that returns a Widget.
  ///
  /// Typically the returned [Widget] (or a descendant)
  /// will reference some aspect of the object containing the observed [Event].
  ///
  /// ```dart
  /// // example
  /// builder: (context) => Text(myCount.value.toString())
  /// ```
  final WidgetBuilder builder;

  /// Creates a [Widget] that rebuilds when an [Event] occurs.
  ///
  /// Query the object that defined the Event (if appropriate) to determine details of what changed.
  EventSubscriber({Key key, @required this.event, @required this.builder}) : super(key: key);

  @override
  _EventSubscriberState createState() => _EventSubscriberState();
}

///////////////

class _EventSubscriberState extends State<EventSubscriber> {
  @override
  void initState() {
    super.initState();
    // Subscribe the [_update] method to the [Event]
    widget.event.subscribe((_) => _update());
  }

  @override
  void dispose() {
    try {
      widget.event.unsubscribe((_) => _update());
    } catch (error) {
      throw SubscriberError(error, 'dispose');
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(EventSubscriber oldWidget) {
    super.didUpdateWidget(oldWidget);
    try {
      if (widget.event != oldWidget.event) {
        // remove subscriber from oldWidget
        widget.event.unsubscribe((_) => _update());
        // add subscribers in new widget
        widget.event.subscribe((_) => _update());
      }
    } catch (error) {
      throw SubscriberError(error, 'didUpdateWidget');
    }
  }

  /// The handler subscribed to this Widgets associated [Event].
  ///
  /// Causes the widget to rebuild.
  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: widget.builder);
  }
}
