//Package imports:
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';

//Project imports:
part 'appointment_event.dart';
part 'appointment_state.dart';


///AppointmentBloc: Here we would have the Appointment domain logic.
class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {

  //Here the StreamController can be a state or a DomainModel
  final _appointmentStreamController = StreamController<bool>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();


  //Constructor
  //You have to declare the StateInitial as the first state
  AppointmentBloc() : super(AppointmentStateInitial()) {
    // on<AppointmentEventFetchBasicData>(_fetchBasicAppointmentDataEventToState);
    // on<AppointmentEventNavigateTo>(_navigateToEventToState);
  }


  //Getters
  Stream<bool> get streamAppointment => _appointmentStreamController.stream;


}