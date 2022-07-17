//Package imports:
import 'dart:async';

//Project imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_genres_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_phones_list_use_case.dart';
import 'package:my_online_doctor/domain/models/sign_up_patient_domain_model.dart';
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


  
  //Constructor
  //You have to declare the StateInitial as the first state
  RegisterBloc() : super(RegisterStateInitial()) {
    on<RegisterEventFetchBasicData>(_fetchBasicRegisterDataEventToState);

  }


  //Getters
  Stream<bool> get streamRegister => _registerStreamController.stream;
  List<String> get phonesList => _phonesList;
  String? get phoneSelected => _phoneSelected;
  List<String> get genresList => _genresList;
  String? get genreSelected => _genreSelected;
  DateTime get birthDate => _birthDate;


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