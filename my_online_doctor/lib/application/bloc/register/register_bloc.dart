//Package imports:
import 'dart:async';

//Project imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_genres_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_phones_list_use_case.dart';
import 'package:my_online_doctor/domain/models/sign_up_patient_domain_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';
part 'register_event.dart';
part 'register_state.dart';


///RegisterBloc: Here we would have the register domain logic.
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  //Here the StreamController can be a state or a DomainModel
  final _registerStreamController = StreamController<bool>();


  //Instances of use cases:
  final GetPhonesUseCaseContract _phonesUseCase = GetPhonesUseCaseContract.get(); 
  final GetGenreUseCaseContract _genreUseCase = GetGenreUseCaseContract.get();


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

    //TODO: VALIDACIONES

    final response = await getIt<RepositoryManager>()
    .request(operation: RepositoryConstant.operationPost.key, endpoint: RepositoryPathConstant.register.path,
      body: event.signUpPatientDomainModel.toJson())
    .catchError((onError) {

      // showDialog(
      //   context: getIt<ContextManager>().context,
      //   builder: (BuildContext context) => const DialogComponent(
      //     textTitle: 'Troste',
      //     textQuestion: 'NOOOO',
      //   ));
      return null;

    });

    if (response != null) {
      emit(RegisterStateSuccess());
    } 


    emit(RegisterStateDataFetched());

  }



  //Private methods:

  ///This method is called when the event is [RegisterEventFetchBasicData]
  ///It sets the initial data of the register page.
  void _setInitalRegisterData() {
    _phoneSelected = _phonesList.first;
    _genreSelected = _genresList.first;
  }

  //To load the view:
  void _loadView() => _registerStreamController.sink.add(true);


}