import 'dart:async';
import 'package:flutter/material.dart';
import 'base_event.dart';

abstract class BaseBloc {
  StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();
      Sink<BaseEvent> get event => _eventStreamController.sink;

  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception("Event không hợp lệ");
      }
      dispatchEvent(event);
    });
  }
  
  void dispatchEvent(event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}
