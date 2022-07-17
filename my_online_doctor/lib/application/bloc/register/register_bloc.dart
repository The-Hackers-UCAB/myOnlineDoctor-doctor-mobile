//Package imports:
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
import 'package:my_online_doctor/application/use_cases/getters/get_genres_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_phones_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/register_patient/register_patient_use_case.dart';
import 'package:my_online_doctor/domain/models/sign_up_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/utils/app_util.dart';
part 'register_event.dart';
part 'register_state.dart';


///RegisterBloc: Here we would have the register domain logic.
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  //Here the StreamController can be a state or a DomainModel
  final _registerStreamController = StreamController<bool>();


  //Instances of use cases:
  final GetPhonesUseCaseContract _phonesUseCase = GetPhonesUseCaseContract.get(); 
  final GetGenreUseCaseContract _genreUseCase = GetGenreUseCaseContract.get();
  final RegisterPatientUseCaseContract _registerPatientUseCase = RegisterPatientUseCaseContract.get();


  //Variables:
  List<String> _phonesList = [];
  String? _phoneSelected;
  List<String> _genresList = [];
  String? _genreSelected; 
  DateTime _birthDate = DateTime.now();
  bool _termsAndConditionsSelected = false;


  
  //Constructor
  //You have to declare the StateInitial as the first state
  RegisterBloc() : super(RegisterStateInitial()) {
    on<RegisterEventFetchBasicData>(_fetchBasicRegisterDataEventToState);
    on<RegisterEventRegisterPatient>(_registerPatientEventToState);

  }


  //Getters
  Stream<bool> get streamRegister => _registerStreamController.stream;
  List<String> get phonesList => _phonesList;
  String? get phoneSelected => _phoneSelected;
  List<String> get genresList => _genresList;
  String? get genreSelected => _genreSelected;
  DateTime get birthDate => _birthDate;
  bool get termsAndConditionsSelected => _termsAndConditionsSelected;


  //Setters
  set phoneSelected(String? value) {
    _phoneSelected = value;
    _loadView();
  }

  set genreSelected(String? value) {
    _genreSelected = value;
    _loadView();
  }

  set birthDate(DateTime value) {
    _birthDate = value;
    _loadView();
  }

  set termsAndConditionsSelected(bool value) {
    _termsAndConditionsSelected = value;
    _loadView();
  }



  //Methods:

  ///This method is called when the event is [RegisterEventFetchBasicData]
  ///It fetches the basic data of the register page.
  void _fetchBasicRegisterDataEventToState(RegisterEvent event, Emitter<RegisterState> emit) async {

    emit(RegisterStateLoading());

    _phonesList = await _phonesUseCase.run();
    _genresList = await _genreUseCase.run();

    _setInitalRegisterData();

    _loadView();

    emit(RegisterStateDataFetched());
  }



  ///This method is called when the event is [RegisterEventRegisterPatient]
  ///It registers the patient.
  void _registerPatientEventToState(RegisterEventRegisterPatient event, Emitter<RegisterState> emit) async{

    emit(RegisterStateLoading());

    if( !_registerPatientValidation(event) ) {
      emit(RegisterStateHideLoading());
      return;
    }

    
    final response =  await _registerPatientUseCase.run(event.signUpPatientDomainModel);
    
    if (response != null) {

      _showDialog(TextConstant.successTitle.text, TextConstant.successRegister.text);

      emit(RegisterStateSuccess());

      return;
    }

    emit(RegisterStateHideLoading());


  }



  //Private methods:


  ///This method is called when the event is [RegisterEventRegisterPatient]
  ///It validates the patient data.
  bool _registerPatientValidation(RegisterEventRegisterPatient event)  {

    if(!event.isFormValidated) {
      _showDialog(TextConstant.errorTitle.text, TextConstant.errorFormValidation.text);
      return false;
    }


    if(!_termsAndConditionsSelected) {
      _showDialog(TextConstant.errorTitle.text, TextConstant.termsAndConditionsNotSelected.text);
      return false;
    }


    if(event.signUpPatientDomainModel.password != event.confirmPassword){
      _showDialog(TextConstant.errorTitle.text, TextConstant.passwordNotMatch.text);
      return false;
    }


    if(_birthDate.isAfter(DateTime.now().subtract(const Duration(days: 365 *18))) ) {
      _showDialog(TextConstant.errorTitle.text, TextConstant.birthDateInvalid.text);
      return false;
    }


    return true;
  }


  ///This method is called when the event is [RegisterEventFetchBasicData]
  ///It sets the initial data of the register page.
  void _setInitalRegisterData() {
    _phoneSelected = _phonesList.first;
    _genreSelected = _genresList.first;
  }

  //To load the view:
  void _loadView() => _registerStreamController.sink.add(true);


  //To show the dialog:
  void _showDialog(String textTitle, String textQuestion) async {
    return await AppUtil.showDialogUtil(
      context: getIt<ContextManager>().context, 
      title: textTitle, 
      message: textQuestion);

  }

}