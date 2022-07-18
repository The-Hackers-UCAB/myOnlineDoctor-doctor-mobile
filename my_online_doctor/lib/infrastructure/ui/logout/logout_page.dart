import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/ui/components/base_ui_component.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/colors.dart';

class LogoutPage extends StatelessWidget{

  static const routeName = '/logout';

  @override
  Widget build(BuildContext context) {
    return BaseUIComponent(
      appBar: AppBar( backgroundColor: colorPrimary, title: Text('Logout'), centerTitle: true),
      body: Center(child: Text('Logout')),
    );
  }
}