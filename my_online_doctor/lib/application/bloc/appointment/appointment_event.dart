//Project imports:
part of 'appointment_bloc.dart';

///AppointmentEvent: Here we define the events of the AppointmentBloc.
abstract class AppointmentEvent {}


class AppointmentEventFetchBasicData extends AppointmentEvent {}

class AppointmentEventNavigateTo extends AppointmentEvent {
  final String routeName;
  AppointmentEventNavigateTo(this.routeName);
}

