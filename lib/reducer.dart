import 'package:firestore_sample/actions.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return new AppState(
    counter: counterReducer(state.counter, action),
  );
}
final counterReducer = combineReducers<int>([
  new TypedReducer<int, CounterOnDataEventAction>(_setCounter),
]);

int _setCounter(int oldCounter, CounterOnDataEventAction action) {
  return action.counter;
}