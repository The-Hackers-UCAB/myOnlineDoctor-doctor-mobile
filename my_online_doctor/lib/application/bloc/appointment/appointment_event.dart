//Project imports:
part of 'appointment_bloc.dart';

///AppointmentEvent: Here we define the events of the AppointmentBloc.
abstract class AppointmentEvent {}


class AppointmentEventFetchBasicData extends AppointmentEvent {}

class AppointmentEventNavigateTo extends AppointmentEvent {
  final String routeName;
  final RequestAppointmentModel appointment;
  AppointmentEventNavigateTo(this.routeName, this.appointment);
}

class AppointmentEventNavigateToWith extends AppointmentEvent {
  final String routeName;
  final Object? arguments;
  AppointmentEventNavigateToWith(this.routeName, this.arguments);

}

class AppointmentEventCreated extends AppointmentEvent {}

class AppointmentEventRated extends AppointmentEvent {}

class AppointmentEventRequested extends AppointmentEvent {}

class AppointmentEventStarted extends AppointmentEvent {}

class AppointmentEventFinished extends AppointmentEvent {}

class AppointmentEventNotStarted extends AppointmentEvent {}
