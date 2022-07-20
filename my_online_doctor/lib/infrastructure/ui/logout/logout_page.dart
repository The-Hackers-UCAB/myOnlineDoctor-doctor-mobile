import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_online_doctor/application/bloc/logout/logout_bloc.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/core/constants/min_max_constants.dart';

class LogoutPage extends StatelessWidget {
  static const routeName = '/logout';

  LogoutPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => LogoutBloc(),
      child: BlocBuilder<LogoutBloc, LogoutState>(
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

  Widget _renderBottomNavigationBar(BuildContext context) => Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.05,
      color: colorSecondary);

  ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) =>
      AppBar(backgroundColor: colorPrimary);

  //Widget Body
  Widget _body(BuildContext context, LogoutState state) {
    if (state is LogoutStateInitial) {
      context.read<LogoutBloc>().add(LogoutEventLogoutPatient());
    }

    return Container();
  }

 
}
