//Package imports
import 'package:flutter/material.dart';

class RoutesManager {

  static Route getOnGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      default:
        return MaterialPageRoute(builder: (context) => RegisterBuilder().build());
      }
  }

}

