//Package imports:
import 'package:flutter/material.dart';

//Project imports:
import 'package:my_online_doctor/domain/models/appointment/request_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
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
    return BaseUIComponent(
      appBar: _renderAppBar(context),
      body: _renderBody(context),
      bottomNavigationBar: _renderBottomNavigationBar(context) ,
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
      ],
    ),
  );

}