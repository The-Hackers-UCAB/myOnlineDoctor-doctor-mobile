// Package imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';

//Project imports
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/flavor_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/core/routes_manager.dart';
import 'package:my_online_doctor/infrastructure/ui/components/loading_component.dart';
import 'package:my_online_doctor/infrastructure/ui/login/login_page.dart';
import 'package:my_online_doctor/infrastructure/ui/register/register_page.dart';
import 'package:my_online_doctor/infrastructure/ui/styles/theme.dart';
import 'package:my_online_doctor/infrastructure/utils/device_util.dart';


//This the main function of the app.
void main() {

  InjectionManager.setupInjections(); //Here we setup the injections.

  FlavorManager.make(Flavor.PRODUCTION); //Here we set the flavor that we want to use.

  runApp(const MyOnlineDoctorApp()); //Here we run the app.
}


///MyOnlineDoctorApp: Class that manages the app.
class MyOnlineDoctorApp extends StatelessWidget {
  const MyOnlineDoctorApp({Key? key}) : super(key: key);

 // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    getIt<ContextManager>().context = context;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigatorServiceContract.get().navigatorKey,
      theme: mainTheme(),
      onGenerateRoute: (RouteSettings settings) => RoutesManager.getOnGenerateRoute(settings),
      home: _checkInternet(),
    );
  }



  Widget _checkInternet() {

    return FutureBuilder(
      future: DeviceUtil.checkInternetConnection(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!) {
            return RegisterPage();
            //TO DO: Add the home page.
            // return HomePage();
          } else {
            return const CircularProgressIndicator(color: Colors.blue);
            //TO DO: Add the error page. (No Internet)
            // return NoInternetPage();
          }
        } else {
          return const LoadingComponent();
        }
        
      },
    );
  }


}
