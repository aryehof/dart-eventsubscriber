import 'package:flutter/material.dart';

import 'package:eventnotifier/eventnotifier.dart';
import 'package:eventsubscriber/src/error.dart';

/// A widget that updates when a named EventNotifier event occurs
class EventSubscriber extends StatefulWidget {
  /// A global object that notifies subscribers when data of interest changes.
  final EventNotifier model;

  /// A list of [EventNotifier] event names which when raised, will cause this widget to refresh.
  /// e.g. eventNames: ['myValueChanged']
  final List<String> eventNames;

  /// A function that returns a widget. Typically the returned widget will reference the model
  /// e.g. builder: (context) => Text(myCount.value.toString())
  final WidgetBuilder builder;

  /// Creates a subscriber to a named [EventNotifier] event. Rebuilds when notified that the event has occured.
  /// Query the model (if appropriate) to determine details of what changed.
  EventSubscriber(
      {Key key,
      @required this.model,
      @required this.eventNames,
      @required this.builder})
      : super(key: key);

  @override
  _EventSubscriberState createState() => _EventSubscriberState();
}

///////////////

class _EventSubscriberState extends State<EventSubscriber> {
  List lastArgs;

  @override
  void initState() {
    super.initState();
    if (widget.eventNames.isEmpty) {
      throw SubscriberException(
          'at least one eventName must be specified', 'InitState');
    }
    for (var eventName in widget.eventNames) {
      widget.model.subscribe(eventName, _update);
    }
  }

  @override
  void dispose() {
    try {
      for (var eventName in widget.eventNames) {
        widget.model.remove(eventName, _update);
      }
    } catch (error) {
      throw SubscriberException(error, 'dispose');
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(EventSubscriber oldWidget) {
    super.didUpdateWidget(oldWidget);
    try {
      if (widget.model != oldWidget.model) {
        // remove subscribers from oldWidget
        for (var eventName in oldWidget.eventNames) {
          oldWidget.model.remove(eventName, _update);
        }
        // add subscribers in new widget
        for (var eventName in widget.eventNames) {
          widget.model.subscribe(eventName, _update);
        }
      }
    } catch (error) {
      throw SubscriberException(error, 'didUpdateWidget');
    }
  }

  /// Cause the widget to rebuild. Called when receiving notification of a subscribed event
  void _update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: widget.builder);
  }
}
