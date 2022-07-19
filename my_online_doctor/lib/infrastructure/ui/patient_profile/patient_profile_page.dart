import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class PatientProfilePage extends StatelessWidget{

  static const routeName = '/patient_profile';

  @override
  Widget build(BuildContext context) {
    return BaseUIComponent(
      appBar: AppBar( backgroundColor: colorPrimary, title: Text('Patient Profile'), centerTitle: true),
      body: Center(child: Text('Patient Profile')),
    );
  }
}