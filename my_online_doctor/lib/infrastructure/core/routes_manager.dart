//Package imports:
import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/ui/appointment/view_appointments_page.dart';

//Project imports:
import 'package:my_online_doctor/infrastructure/ui/login/login_page.dart';
import 'package:my_online_doctor/infrastructure/ui/register/register_page.dart';

///RoutesManager: Class that manages the routes.
class RoutesManager {

  static Route getOnGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      
      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (context) => RegisterPage());

      case LoginPage.routeName:
        return MaterialPageRoute(builder: (context) => LoginPage());

      case ViewAppointmentsPage.routeName:
        return MaterialPageRoute(builder: (context) => ViewAppointmentsPage());

      default:
        return MaterialPageRoute(builder: (context) => LoginPage());
      }
  }

}

