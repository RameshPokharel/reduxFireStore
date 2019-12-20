class IncrementCounterAction {}
class RequestCounterDataEventsAction {}

class CancelCounterDataEventsAction {}
class CounterOnDataEventAction {
  final int counter;

  CounterOnDataEventAction(this.counter);
}
class CounterDataPushedAction {}
class CounterOnErrorEventAction {
  final String error;

  CounterOnErrorEventAction(this.error);
}