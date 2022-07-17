// Package imports:
import 'package:get_it/get_it.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_genres_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_phones_list_use_case.dart';

// Project imports:
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

final getIt = GetIt.instance;



///InjectionManager: Class that manages the injection of dependencies.
class InjectionManager {
  static void setupInjections() {

    getIt.registerSingleton<ContextManager>(ContextManager());
    getIt.registerSingleton<RepositoryManager>(RepositoryManager());

    NavigatorServiceContract.inject();

    //USE CASES
    GetPhonesUseCaseContract.inject();
    GetGenreUseCaseContract.inject();

  }
}
