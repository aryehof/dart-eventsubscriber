// Copyright 2020 Aryeh Hoffman. All rights reserved.
// Use of this source code is governed by an Apache-2.0 license that can be
// found in the LICENSE file.

import 'package:event/event.dart';
import 'package:flutter/material.dart';

/// A function definition that returns a Widget, given a context and (optional)
/// [EventArgs] derived object.
typedef _ArgsWidgetBuilder<T extends EventArgs> = Widget Function(BuildContext context, T? args);

/// Represents a [Widget] that supports subscribing to an [Event],
/// that updates (rebuilds) when the [Event] occurs.
///
/// See [Event] at https://pub.dev/packages/event
class EventSubscriber<T extends EventArgs> extends StatefulWidget {
  /// The [Event] to subscribe to, that will cause
  ///  this [EventSubscriber] to update (rebuild).
  ///
  /// ```dart
  /// // example
  /// event: myCount.onValueChanged
  /// ```
  final Event<T> event;

  /// A function ([WidgetBuilder]) that returns a Widget.
  ///
  /// Typically the returned [Widget] (or a descendant)
  /// will reference some aspect of the object containing the observed [Event].
  ///
  /// ```dart
  /// // example
  /// builder: (context) => Text(myCount.value.toString())
  /// ```
  final _ArgsWidgetBuilder<T> builder;

  /// Creates an [EventSubscriber] that rebuilds when an [Event] occurs.
  ///
  /// Query the object that defined the Event (if appropriate) to determine details of what changed.
  EventSubscriber({Key? key, required this.event, required this.builder}) : super(key: key);

  @override
  _EventSubscriberState<T> createState() => _EventSubscriberState<T>();
}

///////////////

class _EventSubscriberState<T extends EventArgs> extends State<EventSubscriber<T>> {
  /// Optional [Event] arguments provided when an [Event] is broadcast.
  T? _lastArgs;

  /// The handler that will be subscribed to this Widgets
  /// associated [Event]. Causes your handler to be called, and
  /// the widget to rebuild.
  void _eventHandler(T? eventArgs) {
    _lastArgs = eventArgs;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // subscribe the [_update] method to the [Event]
    widget.event.subscribe(_eventHandler);
  }

  @override
  void dispose() {
    widget.event.unsubscribe(_eventHandler);
    super.dispose();
  }

  @override
  void didUpdateWidget(EventSubscriber oldWidget) {
    super.didUpdateWidget(oldWidget as EventSubscriber<T>);
    if (widget.event != oldWidget.event) {
      // remove subscriber from oldWidget
      widget.event.unsubscribe(_eventHandler);
      // add subscribers in new widget
      widget.event.subscribe(_eventHandler);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ArgsBuilder<T>(builder: widget.builder, args: _lastArgs);
  }
}

//////////////////////

class _ArgsBuilder<T extends EventArgs> extends StatelessWidget {
  final _ArgsWidgetBuilder<T> builder;
  final T? args;

  const _ArgsBuilder({Key? key, required this.builder, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, args);
  }
}
