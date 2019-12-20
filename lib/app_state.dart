class AppState {
  final int counter;
  final String error;

  AppState({
    this.counter = 0,
    this.error = "",
  });

  AppState copyWith({int counter, String error}) =>
      new AppState(counter: counter ?? this.counter, error: error ?? this.error);
}