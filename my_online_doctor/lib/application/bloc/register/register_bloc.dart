//Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/infrastructure/ui/register/register_page.dart';

//Project imports:
part 'register_event.dart';
part 'register_state.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {


  RegisterBloc() : super(RegisterInitial()) {

  }


}