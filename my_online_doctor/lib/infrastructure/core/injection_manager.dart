// Package imports:
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_online_doctor/application/use_cases/appointments/get_appointments_use_case.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_genres_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/getters/get_phones_list_use_case.dart';
import 'package:my_online_doctor/application/use_cases/login_patient/login_patient.dart';
import 'package:my_online_doctor/application/use_cases/register_patient/register_patient_use_case.dart';

// Project imports:
import 'package:my_online_doctor/infrastructure/core/context_manager.dart';
import 'package:my_online_doctor/infrastructure/core/navigator_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';
import 'package:my_online_doctor/infrastructure/providers/local_storage/local_storage_repository.dart';

final getIt = GetIt.instance;



///InjectionManager: Class that manages the injection of dependencies.
class InjectionManager {
  static void setupInjections() async {


    NavigatorServiceContract.inject();

    getIt.registerSingleton<ContextManager>(ContextManager());
    getIt.registerSingleton<RepositoryManager>(RepositoryManager());

    WidgetsFlutterBinding.ensureInitialized();
    await Preferences.init();

    //USE CASES
    GetPhonesUseCaseContract.inject();
    GetGenreUseCaseContract.inject();
    RegisterPatientUseCaseContract.inject();
    LoginPatientUseCaseContract.inject();
    GetAppointmentsUseCaseContract.inject();


  }
}
