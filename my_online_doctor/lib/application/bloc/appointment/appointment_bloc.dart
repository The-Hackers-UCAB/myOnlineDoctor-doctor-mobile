//Package imports:
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/appointments/accept_appointment_use_case.dart';

//Project imports:
import 'package:my_online_doctor/application/use_cases/appointments/cancel_appointment_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/get_appointments_use_case.dart';
import 'package:my_online_doctor/application/use_cases/appointments/reject_appointment_use_case.dart';
import 'package:my_online_doctor/domain/models/appointment/accept_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/cancel_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/reject_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/dialog_component.dart';
import 'package:my_online_doctor/infrastructure/utils/app_util.dart';
part 'appointment_event.dart';
part 'appointment_state.dart';


///AppointmentBloc: Here we would have the Appointment domain logic.
class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {

  //Here the StreamController can be a state or a DomainModel
  final _appointmentStreamController = StreamController<List<RequestAppointmentModel>>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();
  final GetAppointmentsUseCaseContract _getAppointmentUseCase = GetAppointmentsUseCaseContract.get();
  final CancelAppointmentsUseCaseContract _cancelAppointmentUseCase = CancelAppointmentsUseCaseContract.get();
  final RejectAppointmentsUseCaseContract _rejectAppointmentUseCase = RejectAppointmentsUseCaseContract.get();
  final AcceptAppointmentsUseCaseContract _acceptAppointmentUseCase = AcceptAppointmentsUseCaseContract.get();


  //Constructor
  //You have to declare the StateInitial as the first state
  AppointmentBloc() : super(AppointmentStateInitial()) {
    on<AppointmentEventFetchBasicData>(_fetchBasicAppointmentDataEventToState);
    on<AppointmentEventNavigateTo>(_navigateToEventToState);
    on<AppointmentEventCancelled>(_cancelledAppointmentEventToState);
    on<AppointmentEventRejected>(_rejectedAppointmentEventToState);
    on<AppointmentEventAccepted>(_acceptedAppointmentEventToState);
  }


  //Getters
  Stream<List<RequestAppointmentModel>> get streamAppointment => _appointmentStreamController.stream;


  //Setters


  //Methods:

  ///This method is called when the event is [AppointmentEventFetchBasicData]
  ///It fetches the basic data of the Appointment page.
  void _fetchBasicAppointmentDataEventToState(AppointmentEvent event, Emitter<AppointmentState> emit) async {

    emit(AppointmentStateLoading());

    // var response = await _getAppointmentUseCase.run();

    // var decode = requestAppointmentModelFromJson(response);

    // if(decode.value.isNotEmpty) {

    //   var appointmentList = decode.value.map((e) => e).toList();

    //   _appointmentStreamController.sink.add(appointmentList);

    // } else {

    //   _appointmentStreamController.sink.add([]);

    // }

    _appointmentStreamController.sink.add([]);

    emit(AppointmentStateHideLoading());
  }


  ///This method is called when the event is [AppointmentEventNavigateTo]
  ///It navigates to the specified page.
  void _navigateToEventToState(AppointmentEventNavigateTo event, Emitter<AppointmentState> emit) {
    _navigatorManager.navigateTo(event.routeName, arguments: event.appointment);
  }


  ///This method is called when the event is [AppointmentEventCancelled]
  ///It cancels the appointment.
  void _cancelledAppointmentEventToState(AppointmentEventCancelled event, Emitter<AppointmentState> emit) async {

    emit(AppointmentStateLoading());

    final response = await _cancelAppointmentUseCase.run(event.appointment);

    if(response != null) {

      await showDialog(
        context: getIt<ContextManager>().context,
          builder: (BuildContext superContext) => DialogComponent(
              textTitle: TextConstant.successTitle.text,
              textQuestion: TextConstant.successCancelAppointment.text,
            )
        );

    }



    emit(AppointmentStateHideLoading());
  }



  ///This method is called when the event is [AppointmentEventRejected]
  ///It rejects the appointment.
  ///It shows a dialog to the user to confirm the rejection.
  ///If the user confirms, it calls the use case to reject the appointment.
  ///If the user cancels, it does nothing.
  ///It also shows a dialog to the user if the appointment is rejected.
  void _rejectedAppointmentEventToState(AppointmentEventRejected event, Emitter<AppointmentState> emit) async {

    emit(AppointmentStateLoading());

    final response = await _rejectAppointmentUseCase.run(event.appointment);

    if(response != null) {

      await showDialog(
        context: getIt<ContextManager>().context,
          builder: (BuildContext superContext) => DialogComponent(
              textTitle: TextConstant.successTitle.text,
              textQuestion: TextConstant.successRejectAppointment.text,
            )
        );

    }

    emit(AppointmentStateHideLoading());
  }


  ///This method is called when the event is [AppointmentEventAccepted]
  ///It accepts the appointment.
  ///It shows a dialog to the user to confirm the acceptance.
  ///If the user confirms, it calls the use case to accept the appointment.
  ///If the user cancels, it does nothing.
  ///It also shows a dialog to the user if the appointment is accepted.
  void _acceptedAppointmentEventToState(AppointmentEventAccepted event, Emitter<AppointmentState> emit) async {

    emit(AppointmentStateLoading());

    final response = await _acceptAppointmentUseCase.run(event.appointment);

    if(response != null) {

      await showDialog(
        context: getIt<ContextManager>().context,
          builder: (BuildContext superContext) => DialogComponent(
              textTitle: TextConstant.successTitle.text,
              textQuestion: TextConstant.successAcceptAppointment.text,
            )
        );

    }

    emit(AppointmentStateHideLoading());
  }





  //Private methods:

  //To load the view:
  // void _loadView() => _appointmentStreamController.sink.add(true);


  //To show the dialog:
  void _showDialog(String textTitle, String textQuestion) async {
    return await AppUtil.showDialogUtil(
      context: getIt<ContextManager>().context, 
      title: textTitle, 
      message: textQuestion);

  }


}