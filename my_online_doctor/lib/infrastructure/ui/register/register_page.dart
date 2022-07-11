//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Prokect imports:
import 'package:my_online_doctor/application/bloc/register/register_bloc.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/reusable_widgets.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';



class RegisterPage extends StatelessWidget {
  static const routeName = '/register';

  const RegisterPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => RegisterBloc(),
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(),
            body: renderLogoImageView(context),
            bottomNavigationBar: _renderBottomNavigationBar(),
          );
        },
      ),
    );
  }


  ///Widget AppBar
  PreferredSizeWidget _renderAppBar() => 
    AppBar(backgroundColor: colorPrimary);


  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar() =>
    Container(width: double.infinity, height: 30, color: colorSecondary);


}