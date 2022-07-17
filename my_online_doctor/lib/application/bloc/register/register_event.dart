//Project imports:
part of 'register_bloc.dart';

///RegisterEvent: Here we define the events of the RegisterBloc.
abstract class RegisterEvent {}


class RegisterEventFetchBasicData extends RegisterEvent {}

class RegisterEventRegisterPatient extends RegisterEvent {
  final SignUpPatientDomainModel signUpPatientDomainModel;
  final bool isFormValidated;

  RegisterEventRegisterPatient(this.signUpPatientDomainModel, this.isFormValidated);
}
