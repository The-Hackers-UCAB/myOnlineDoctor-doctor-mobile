//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Project imports:
import 'package:my_online_doctor/application/bloc/appointment/appointment_bloc.dart';
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/min_max_constants.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/button_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/reusable_widgets.dart';
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
    title: Text(TextConstant.appointmentTitle.text),
    centerTitle: true,
  );


  //Widget Body
  Widget _body(BuildContext context, AppointmentState state) {
    
    if(state is AppointmentStateInitial) {
      context.read<AppointmentBloc>().add(AppointmentEventFetchBasicData());
    }

    return Stack(
      children: [
        if(state is! AppointmentStateInitial) _viewAppointmentsRenderView(context),
        if(state is AppointmentStateInitial || state is AppointmentStateLoading) const LoadingComponent(),
      ],
    );
  }


  Widget _viewAppointmentsRenderView(context){

    // return Padding(
    //   padding: EdgeInsets.only(top: 20, bottom: 20),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     mainAxisSize: MainAxisSize.max,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       _appointmentStreamBuilder(context),
    //       _requestAppointmentRenderButton(context),
    //     ],
    //   ),
    // );

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            padding: generalMarginView,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: _appointmentStreamBuilder(context),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.12,
            margin: generalMarginView,
            child:_requestAppointmentRenderButton(context),
          ) 
        ),
        
        // heightSeparator(context, 0.05),
        // _requestAppointmentRenderButton(context)
      ],
    );

  }

  //StreamBuilder for the Login Page
  Widget _appointmentStreamBuilder(BuildContext builderContext) => StreamBuilder<RequestAppointmentValue?>(
    stream: builderContext.read<AppointmentBloc>().streamAppointment,
    builder: (BuildContext context, AsyncSnapshot<RequestAppointmentValue?> snapshot) {

      if(snapshot.hasData) {
        return const Center(child: CircularProgressIndicator(color: colorError,));
        // return _loginRenderView(context);
      } 

      return const LoadingComponent();
    }
  );


  Widget _requestAppointmentRenderButton(BuildContext context) => Container(
    margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 25),
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.065,
    child:  ButtonComponent(
      title: TextConstant.requestAppointment.text,
      // actionButton:  () => _signIn(context),
    )
  );
  


}