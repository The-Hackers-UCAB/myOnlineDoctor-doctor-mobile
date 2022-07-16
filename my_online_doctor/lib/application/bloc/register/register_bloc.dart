//Package imports:
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_phones_list_use_case.dart';
import 'package:my_online_doctor/domain/models/sign_up_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/ui/register/register_page.dart';

//Project imports:
part 'register_event.dart';
part 'register_state.dart';


///RegisterBloc: Here we would have the register domain logic.
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  //Here the StreamController can be a state or a DomainModel
  final _registerStreamController = StreamController<bool>();


  //Instances of the use cases:
  final GetPhonesUseCaseContract _phonesUseCase = GetPhonesUseCaseContract.get(); 


  //Variables:
  List<String> _phonesList = [];
  String? _phoneSelected;


  //Getters
  Stream<bool> get streamRegister => _registerStreamController.stream;
  List<String> get phonesList => _phonesList;
  String? get phoneSelected => _phoneSelected;


  //Constructor
  //You have to declare the StateInitial as the first state
  RegisterBloc() : super(RegisterStateInitial()) {
    on<RegisterEventFetchBasicData>(_fetchBasicRegisterDataEventToState);
    on<RegisterEventPhoneChanged>(_phoneChangedEvent);

  }


  //Methods:

  ///This method is called when the event is [RegisterEventFetchBasicData]
  ///It fetches the basic data of the register page.
  void _fetchBasicRegisterDataEventToState(RegisterEvent event, Emitter<RegisterState> emit) async {

    emit(RegisterStateLoading());

    _phonesList = await _phonesUseCase.run();

    _setInitalRegisterData();

    _registerStreamController.sink.add(true);

    emit(RegisterStateDataFetched());
  }


  ///This method is called when the event is [RegisterEventPhoneChanged]
  ///It changes the phone selected.
  void _phoneChangedEvent(RegisterEventPhoneChanged event, Emitter<RegisterState> emit) {
    _phoneSelected = event.phonePrefix;
    _registerStreamController.sink.add(true);
  }




  void _setInitalRegisterData() {
    _phoneSelected = _phonesList.first;
  }


}