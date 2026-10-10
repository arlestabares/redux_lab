import 'package:flutter_test/flutter_test.dart';

import 'package:redux_enterprise_lab/features/counter/redux/counter_actions.dart';
import 'package:redux_enterprise_lab/features/counter/redux/counter_reducer.dart';

void main() {
  group('counterReducer', () {
    test('increments the counter', () {
      final result = counterReducer(0, const IncrementCounterAction());

      expect(result, 1);
    });

    test('decrements the counter', () {
      final result = counterReducer(5, const DecrementCounterAction());

      expect(result, 4);
    });

    test('resets the counter', () {
      final result = counterReducer(10, const ResetCounterAction());

      expect(result, 0);
    });

    test('preserves the state for an unknown action', () {
      final result = counterReducer(7, 'UNKNOWN');

      expect(result, 7);
    });
  });
}
