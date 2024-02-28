import 'dart:async';

import 'package:bit_merge_mobile/packages/core/core.dart';

class BusEvent<T> {
  String tag;
  T? data;

  BusEvent(this.tag, {this.data});

  @override
  String toString() {
    return "BusEvent($tag -> $data)";
  }
}

class EventBus {
  final StreamController<BusEvent> _streamController;

  EventBus({bool sync = false}) : _streamController = StreamController<BusEvent>.broadcast(sync: sync);

  EventBus.customController(StreamController<BusEvent> controller) : _streamController = controller;

  StreamSubscription<BusEvent> listen(
    Function(BusEvent event) onEvent, {
    Function? onError,
    Function()? onDone,
    bool? cancelOnError,
  }) {
    return _streamController.stream.listen(onEvent, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  void fire(BusEvent event) {
    Log.debug("event called => $event");
    _streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}
