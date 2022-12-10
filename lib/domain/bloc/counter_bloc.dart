import 'dart:async';

enum CounterEvents { incrementEvent, decrementEvent }

class CounterBloc {
  int _count = 0;
  
  
  final _inputEventController = StreamController<CounterEvents>();
  StreamSink<CounterEvents> get inputEventSink => _inputEventController.sink;
  
  final _outputStateController = StreamController<int>();
  Stream<int> get outputStateStream => _outputStateController.stream;
  
  
  Future<void> _changeCounterState(CounterEvents event) async {
    if (event == CounterEvents.incrementEvent) {
      _count++;
    } else if(event == CounterEvents.decrementEvent) {
      _count--;
    }else {
      throw Exception('Передается неправильный эвент');
    }
    
    _outputStateController.sink.add(_count);
  }
  
  
  CounterBloc() {
    _inputEventController.stream.listen(_changeCounterState);
  }
  Future<void> dispose() async {
    _inputEventController.close();
    _outputStateController.close();
  }
}


