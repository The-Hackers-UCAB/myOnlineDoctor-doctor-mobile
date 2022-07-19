//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
import 'package:my_online_doctor/application/bloc/appointment/appointment_bloc.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class ViewAppointmentsPage extends StatelessWidget{

  static const routeName = '/view_appointments';

  ViewAppointmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => AppointmentBloc(),
      child: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(context),
            body: _body(context, state),
          );
        },
      ),
    );
  }

  ///Widget AppBar
  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar( 
    backgroundColor: colorPrimary,
    title: const Text('Citas Médicas'),
    centerTitle: true,
  );


  //Widget Body
  Widget _body(BuildContext context, AppointmentState state) {
    
    if(state is AppointmentStateInitial) {
      context.read<AppointmentBloc>().add(AppointmentEventFetchBasicData());
    }

    return Stack(
      children: [
        if(state is! AppointmentStateInitial)  _appointmentStreamBuilder(context),
        if(state is AppointmentStateInitial || state is AppointmentStateLoading) const LoadingComponent(),
      ],
    );
  }


  //StreamBuilder for the Login Page
  Widget _appointmentStreamBuilder(BuildContext builderContext) => StreamBuilder<bool>(
    stream: builderContext.read<AppointmentBloc>().streamAppointment,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {

      if(snapshot.hasData) {
        return const Center(child: CircularProgressIndicator(color: colorError,));
        // return _loginRenderView(context);
      } 

      return const LoadingComponent();
    }
  );
  


}