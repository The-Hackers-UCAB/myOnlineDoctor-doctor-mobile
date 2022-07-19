import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class SearchDoctorPage extends StatelessWidget{

  static const routeName = '/search_doctor';

  @override
  Widget build(BuildContext context) {
    return BaseUIComponent(
      appBar: AppBar( backgroundColor: colorPrimary, title: Text('Buscar Doctores'), centerTitle: true),
      body: Center(child: Text('SearchDoctorPage')),
    );
  }
}