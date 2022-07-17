import 'package:flutter/material.dart';

class ViewAppointmentsPage extends StatelessWidget{

  static const routeName = '/view_appointments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Appointments'),
      ),
      body: Center(
        child: Text('View Appointments'),
      ),
    );
  }


}