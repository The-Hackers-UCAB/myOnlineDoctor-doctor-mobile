//Project imports:
part of 'logout_bloc.dart';

///LoginEvent: Here we define the events of the LoginBloc.
abstract class LogoutEvent {}


class LogoutEventNavigateTo extends LogoutEvent {
  final String routeName;
  LogoutEventNavigateTo(this.routeName);
}

class LogoutEventLogoutPatient extends LogoutEvent {}


