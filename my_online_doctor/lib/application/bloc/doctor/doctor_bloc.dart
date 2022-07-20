//Package imports:
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
part 'doctor_event.dart';
part 'doctor_state.dart';

///DoctorBloc: Here we would have the Doctor domain logic.
class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {

  //Here the StreamController can be a state or a DomainModel
  final _doctorStreamController = StreamController<bool>();

  DoctorBloc(): super(DoctorStateInitial()){
    on<DoctorEventFetchBasicData>(_fetchBasicDataEventToState);
  }


  //Getters
  Stream<bool> get streamDoctor => _doctorStreamController.stream;

  //Methods:
  void _fetchBasicDataEventToState(DoctorEventFetchBasicData event, Emitter<DoctorState> emit) {

    emit(DoctorStateLoading());

    //TODO: Here we would have the domain logic.

    emit(DoctorStateHideLoading());
  }



  





}


  //Instances of use cases: