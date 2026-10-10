import 'counter_actions.dart';

int counterReducer(int state, dynamic action) {
  if (action is IncrementCounterAction) {
    return state + 1;
  }

  if (action is DecrementCounterAction) {
    return state - 1;
  }

  if (action is ResetCounterAction) {
    return 0;
  }

  return state;
}
