//Package imports:
import 'package:flutter/material.dart';
import 'package:my_online_doctor/infrastructure/ui/register/register_page.dart';

//Project imports:

class RoutesManager {

  static Route getOnGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      
      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (context) => RegisterPage());

      default:
        return MaterialPageRoute(builder: (context) => RegisterPage());
      }
  }

}

