//Project imports:
part of 'login_bloc.dart';

///LoginEvent: Here we define the events of the LoginBloc.
abstract class LoginEvent {}


class LoginEventFetchBasicData extends LoginEvent {}

class LoginEventLoginPatient extends LoginEvent {
  final SignInPatientDomainModel signUpPatientDomainModel;
  final bool isFormValidated;

  LoginEventLoginPatient(this.signUpPatientDomainModel, this.isFormValidated);
}
