//Package imports:
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/logout_patient/logout_patient.dart';

//Project imports
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/utils/app_util.dart';

import '../../../infrastructure/ui/components/dialog_component.dart';
part 'logout_event.dart';
part 'logout_state.dart';


///LoginBloc: Here we would have the Login domain logic.
class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {

  //Here the StreamController can be a state or a DomainModel
  final _logoutStreamController = StreamController<bool>();

  //Instances of use cases:
  final NavigatorServiceContract _navigatorManager = NavigatorServiceContract.get();
  final LogoutPatientUseCaseContract _logoutPatientUseCase = LogoutPatientUseCaseContract.get();



 //Constructor
  //You have to declare the StateInitial as the first state
  LogoutBloc() : super(LogoutStateInitial()) {
    on<LogoutEventNavigateTo>(_navigateToEventToState);
    on<LogoutEventLogoutPatient>(_logoutPatientEventToState);

  }


  //Getters
  Stream<bool> get streamLogin => _logoutStreamController.stream;

  //Methods:


  ///This method is called when the event is [LogoutEventNavigateTo]
  ///It navigates to the specified page.
  void _navigateToEventToState(LogoutEventNavigateTo event, Emitter<LogoutState> emit) {
    _navigatorManager.navigateTo(event.routeName);
  }


  ///This method is called when the event is [LogoutEventLogoutPatient]
  ///It logs in the patient.
  void _logoutPatientEventToState(LogoutEventLogoutPatient event, Emitter<LogoutState> emit) async {

      var context = getIt<ContextManager>().context;


      // mano esto codigo hace que explote el beta 

      // var response2 = await showDialog(
      //     context: context,
      //     builder: (BuildContext dialogContext) => const DialogComponent(
      //         textTitle: 'Cita médica',
      //         textQuestion: 'Desea atenter su llamada?',
      //         cancelButton: true));

    emit(LogoutStateLoading());
    final response =  await _logoutPatientUseCase.run();
    
    
    if (response != null) {
      _showDialog('Paciente Deslogueado exitosamente','Paciente Deslogueado exitosamente');
      _navigatorManager.navigateToWithReplacement('/login');

      emit(LogoutStateSuccess());

      return;
    }
    
    _loadView();
    emit(LogoutStateHideLoading());
  }



  //Private methods:


  ///This method is called when the event is [LogoutEventLogoutPatient]

  //To load the view:
  void _loadView() => _logoutStreamController.sink.add(true);


  //To show the dialog:
  void _showDialog(String textTitle, String textQuestion) async {
    return await AppUtil.showDialogUtil(
      context: getIt<ContextManager>().context, 
      title: textTitle, 
      message: textQuestion);
  }


}