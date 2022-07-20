//Package imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_online_doctor/application/bloc/appointment/appointment_bloc.dart';

//Project imports:
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';
import 'package:my_online_doctor/domain/services/appointment_status_color_service.dart';
import 'package:my_online_doctor/infrastructure/core/constants/min_max_constants.dart';
import 'package:my_online_doctor/infrastructure/core/constants/text_constants.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/button_component.dart';
import 'package:my_online_doctor/infrastructure/ui/components/reusable_widgets.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class AppointmentDetailPage extends StatefulWidget {
  static const routeName = '/appointment_detail';

  final RequestAppointmentModel appointment;

  AppointmentDetailPage({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  _AppointmentDetailPageState createState() => _AppointmentDetailPageState();
}

class _AppointmentDetailPageState extends State<AppointmentDetailPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy:  false,
      create: (context) => AppointmentBloc(),
      child: BlocBuilder<AppointmentBloc, AppointmentState>(
        builder: (context, state) {
          return BaseUIComponent(
            appBar: _renderAppBar(context),
            body: _renderBody(context),
            bottomNavigationBar: _renderBottomNavigationBar(context) ,
          );
        },
      ),
    );
    
  }

  PreferredSizeWidget _renderAppBar(BuildContext context) => AppBar(
      backgroundColor: colorPrimary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      )
    );


  //Widget Bottom Navigation Bar
  Widget _renderBottomNavigationBar(BuildContext context) => 
    Container(width: double.infinity, height: MediaQuery.of(context).size.height * 0.05, color: colorSecondary);

  Widget _renderBody(BuildContext context) => Scaffold(
    body: ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Center(
          child: Image.asset('assets/images/doctor_logo.png'
            , width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.2, 
          ),
        ),

        heightSeparator(context, 0.01),
        _buildAppointmentTopInformation(context),
        heightSeparator(context, 0.05),
        _buildAppointmentStatus(context),
        heightSeparator(context, 0.01),
        _buildAppointmentDateTime(context),
        heightSeparator(context, 0.01),
        _buildAppointmentDuration(context),
        heightSeparator(context, 0.01),
        _buildAppointmentType(context),
        heightSeparator(context, 0.01),
        _buildAppointmentDescription(context),
        if(widget.appointment.status == 'ACEPTADA')  Container(
            height: MediaQuery.of(context).size.height * 0.10,
            margin: generalMarginView,
            child:  _appointmentRenderButton(context, false),
        ),
        if(widget.appointment.status == 'AGENDADA')  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                margin: generalMarginView,
                child: _appointmentRenderButton(context, false),
                      ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                margin: generalMarginView,
                child: _appointmentRenderButton(context, true),
                      ),
            ),
          ]
        ),


      ],
    ),
  );



  Widget _buildAppointmentTopInformation(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(widget.appointment.specialty.specialty,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 30, color: colorPrimary),
      ),
      heightSeparator(context, 0.01),
      widget.appointment.doctor.gender == 'M' ? 
        Text('Dr. ${widget.appointment.doctor.firstName} ${widget.appointment.doctor.firstSurname}', style: const TextStyle(fontSize: 20),): 
        Text('Dra. ${widget.appointment.doctor.firstName} ${widget.appointment.doctor.firstSurname}', style: const TextStyle(fontSize: 20))
    ],
  );


  Widget _buildAppointmentStatus(BuildContext context) => Padding(
    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Status actual: ',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
        ),
        Text(widget.appointment.status,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontSize: 16, color: AppointmentStatusColorService.getAppointmentStatusColor(widget.appointment.status)),
        ),
      ],
    ),
  );


  Widget _buildAppointmentDateTime(BuildContext context) => Padding(
    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Fecha y hora: ', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),),
        Text(widget.appointment.date != null ? DateFormat('dd/MM/yyyy hh:mm a').format(widget.appointment.date!) : 'Por Definir',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
        ),
      ],
    ),
  );



  Widget _buildAppointmentDuration(BuildContext context) => Padding(
    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Duración: ', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),),
        Text(widget.appointment.duration != null ? '${widget.appointment.duration.toString()} horas' : 'Por Definir',
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
        ),
      ],
    ),
  );



  Widget _buildAppointmentType(BuildContext context) => Padding(
    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Modalidad: ', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),),
        Text(widget.appointment.type,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),
        ),
      ],
    ),
  );


  Widget _buildAppointmentDescription(BuildContext context) => Padding(
    padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Motivo de solicitud: ', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),),
          heightSeparator(context, 0.01),
          Text(widget.appointment.description,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16), maxLines: null, textAlign: TextAlign.justify,
          ),
        ],
      ),
    ),
  );


    Widget _appointmentRenderButton(BuildContext context, bool isAccept) => Container(
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 25),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.065,
      child:  ButtonComponent(
        style: isAccept ? ButtonComponentStyle.accepted : ButtonComponentStyle.canceled,
        title: isAccept ? TextConstant.acceptAppointment.text : TextConstant.cancelAppointment.text,
        // actionButton:  () => _signIn(context),
      )
  );



}