//Project imports:
part of 'register_bloc.dart';

///RegisterEvent: Here we define the events of the RegisterBloc.
abstract class RegisterEvent {}


class RegisterEventFetchBasicData extends RegisterEvent {}

class RegisterEventRegisterPatient extends RegisterEvent {
  final SignUpPatientDomainModel signUpPatientDomainModel;

  RegisterEventRegisterPatient(this.signUpPatientDomainModel);
}

class RegisterEventPhoneChanged extends RegisterEvent {
  final String phonePrefix;

  RegisterEventPhoneChanged(this.phonePrefix);
}