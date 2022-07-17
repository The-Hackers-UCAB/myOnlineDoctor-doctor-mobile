//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


//Project imports:
import 'package:my_online_doctor/application/bloc/login/login_bloc.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';



class LoginPage extends StatelessWidget {

  static const routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(context),
            body: _body(context, state),
            bottomNavigationBar: _renderBottomNavigationBar(context),
          );
        },
      ),
    );
  }


  ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar( backgroundColor: colorPrimary);

  
  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar(BuildContext context) => 
    Container(width: double.infinity, height: MediaQuery.of(context).size.height * 0.05, color: colorSecondary);

  //Widget Body
  Widget _body(BuildContext context, LoginState state) {
    
    if(state is LoginStateInitial) {
      context.read<LoginBloc>().add(LoginEventFetchBasicData());
    }

    return Stack(
      children: [
        if(state is! LoginStateInitial)  _loginStreamBuilder(context),
        if(state is LoginStateInitial || state is LoginStateLoading) const LoadingComponent(),
        //TODO: Add Login State Error and Success
        // if(state is LoginStateSuccess) const LoginPage()
      ],
    );
  }


  //StreamBuilder for the Login Page
  Widget _loginStreamBuilder(BuildContext builderContext) => StreamBuilder<bool>(
    stream: builderContext.read<LoginBloc>().streamLogin,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

      if(snapshot.hasData) {
        // return _loginRenderView(context);
      } 

      return const LoadingComponent();
    }
  );



}