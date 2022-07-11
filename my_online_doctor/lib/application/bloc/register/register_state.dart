//Project imports:
part of 'register_bloc.dart';

//RegisterState: Here we define the states of the RegisterBloc.
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterHideLoadingState extends RegisterState {}
