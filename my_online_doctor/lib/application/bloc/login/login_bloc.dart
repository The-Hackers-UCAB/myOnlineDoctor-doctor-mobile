//Package imports:
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports
import 'package:my_online_doctor/domain/models/sign_in_patient_domain_model.dart';
part 'login_event.dart';
part 'login_state.dart';


///LoginBloc: Here we would have the Login domain logic.
class LoginBloc extends Bloc<LoginEvent, LoginState> {

  //Here the StreamController can be a state or a DomainModel
  final _loginStreamController = StreamController<bool>();


 //Constructor
  //You have to declare the StateInitial as the first state
  LoginBloc() : super(LoginStateInitial()) {
    on<LoginEventFetchBasicData>(_fetchBasicLoginDataEventToState);

  }


  //Getters
  Stream<bool> get streamLogin => _loginStreamController.stream;


  //Setters


  //Methods:

  //Methods to handle the events:
  void _fetchBasicLoginDataEventToState(LoginEvent event, Emitter<LoginState> emit) {

    emit(LoginStateLoading());
    _loadView();
    emit(LoginStateHideLoading());
  }



  //Private methods:

  //To load the view:
  void _loadView() => _loginStreamController.sink.add(true);


}