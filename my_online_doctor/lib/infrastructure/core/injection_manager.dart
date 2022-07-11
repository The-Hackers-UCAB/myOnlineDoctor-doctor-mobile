// Package imports:
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';

final getIt = GetIt.instance;



///InjectionManager: Class that manages the injection of dependencies.
class InjectionManager {
  static void setupInjections() {

    getIt.registerSingleton<ContextManager>(ContextManager());

    NavigatorServiceContract.inject();

  }
}
