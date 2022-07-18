//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
import 'package:my_online_doctor/application/bloc/appointment/appointment_bloc.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class ViewAppointmentsPage extends StatelessWidget{

  static const routeName = '/view_appointments';

  ViewAppointmentsPage({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     lazy:  false,
  //     create: (context) => AppointmentBloc(),
  //     child: BlocBuilder<AppointmentBloc, AppointmentState>(
  //       builder: (context, state) {
  //         return BaseUIComponent(
  //           appBar: _renderAppBar(context),
  //           body: _body(context, state),
  //           bottomNavigationBar: _renderBottomNavigationBar(context),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {


    return BaseUIComponent(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: colorPrimary,
        centerTitle: true,
      ),
      body: Center(child: Text('ViewAppointmentsPage')),


    );
  }


}