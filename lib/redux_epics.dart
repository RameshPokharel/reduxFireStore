import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:redux_epics/redux_epics.dart';

import 'actions.dart';
import 'app_state.dart';
import 'package:rxdart/rxdart.dart';

final allEpics = combineEpics<AppState>([counterEpic, incrementEpic]);

Stream<dynamic> counterEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions // 1
      .whereType<RequestCounterDataEventsAction>() // 2
      .flatMap((RequestCounterDataEventsAction requestAction) {
    return getUserClicks() // 4
        .map((counter) {
      print(counter);
      return new CounterOnDataEventAction(counter);
    }) // 7
        .takeUntil(actions
            .where((action) => action is CancelCounterDataEventsAction)); // 8
  });
}

Stream<int> getUserClicks() {
  return Firestore.instance
      .document("user/demo")
      .snapshots()
      .map((data) => data['counter'] as int);
  // 6
}

Stream<dynamic> incrementEpic(
    Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions.whereType<IncrementCounterAction>().flatMap((_) {
    return new Stream.fromFuture(Firestore.instance
        .document("user/demo")
        .updateData({'counter': store.state.counter + 1})
        .catchError((error) {
          print(error.toString());
        })
        .then((a) => new CounterDataPushedAction())
        .catchError((error) {
          return new CounterOnErrorEventAction(error.toString());
        }));
  });
}
