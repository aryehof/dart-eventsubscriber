# Changelog - EventSubscriber

## Version 1.2.0  (2020-02-09)

- **Breaking Change**. Event arguments [EventArgs] are now supported.
  - The `builder` argument has been renamed to `handler`, to better reflect that you are supplying a subscriber handler that is called when the event is `broadcast`.
  - A handler requires now two arguments, the first representing the BuildContext, and the second the (optional) [EventArgs] associated with the Event.
    - _before:_
      ~~```builder: (context) => Text(myCount.value.toString()),```~~
    - _after:_
        ```handler: (context, args) => Text(myCount.value.toString()),```
  
  ```dart
  ...
  EventSubscriber(
    event: myCount.onValueChanged,
    handler: (context, args) => Text(myCount.value.toString()),

    // If an Event has arguments, they are now available in your handler.
    // In the example above through `args` argument.
  ),
  ```

  **IMPORTANT**: args should be checked for null before use in a handler, as the handler is called BOTH when an Event occurs, and also by the Flutter framework.  In the latter case, args will always be null.


## Version 1.1.2  (2020-01-31)

- Internal - don't repeat the event handler - refer to a single instance

## Version 1.1.1  (2020-01-29)

- Support [Event] 1.1.0.
- Modified to use new Event methods - broadcast and subscribe.

## Version 1.1.0  (2020-01-23)

- **Breaking Change**. Now supports subscribing to an [Event] instead of [EventNotifier].
- Dependencies changed:
  - Dependency on [EventNotifier] removed.
  - Dependency on [Event] added.

## Version 1.0.3  (2020-01-14)

- Updated to support latest EventNotifier (1.0.5), which includes support for a subscriber to optionally expect some 'argument/s' as a Map.

## Version 1.0.2  (2020-01-13)

- Fixed LICENSE reference to package

## Version 1.0.1  (2020-01-13)

- Fixed formatting and documentation errors.

## Version 1.0.0  (2020-01-13)

- Initial release


[Event]: https://pub.dev/packages/event
[EventNotifier]: https://pub.dev/packages/eventnotifier