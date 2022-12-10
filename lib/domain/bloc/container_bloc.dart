//  С реализации эвентов

import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

enum ContainerEvents { colorRedEvent, colorGreenEvent, randColorEvent }

// Класс для реализации бизнес логики

class ContainerBloc {
  Color _color = Colors.red;

// Стрим контроллер для получение эвентов
  final _inputEventController = StreamController<ContainerEvents>();

  StreamSink<ContainerEvents> get inputEventSink => _inputEventController.sink;

  // Стрим контроллер для отправки нового состояния
  final _outputStateController = StreamController<Color>();
  Stream<Color> get outputStateStream => _outputStateController.stream;
  // Функция
  Future<void> _changeContainerState(ContainerEvents event) async {
    if (event == ContainerEvents.colorRedEvent) {
      _color = Colors.red;
    } else if (event == ContainerEvents.colorGreenEvent) {
      _color = Colors.green;
    } else if (event == ContainerEvents.randColorEvent) {
      _color = Color.fromRGBO(
        Random().nextInt(256),
        Random().nextInt(256),
        Random().nextInt(256),
        1,
      );
    } else {
      throw Exception('Передается неправильный эвент');
    }

    _outputStateController.sink.add(_color);
  }

  ContainerBloc() {
    // Здесь мы подписываемся на поток и обрабатываем события пришедшие со стороны UI и отправляем ответ новым состоянием
    _inputEventController.stream.listen(_changeContainerState);
  }

  Future<void> dispose() async {
    _inputEventController.close();
    _outputStateController.close();
  }
}
