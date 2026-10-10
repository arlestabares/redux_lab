import 'dashboard_actions.dart';

String dashboardReducer(String state, dynamic action) {
  if (action is UpdateDashboardMessageAction) {
    return action.message;
  }

  return state;
}
