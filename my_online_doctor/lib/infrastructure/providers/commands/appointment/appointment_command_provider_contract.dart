import 'package:my_online_doctor/domain/models/appointment/cancel_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

abstract class AppointmentCommandProviderContract {
  static AppointmentCommandProviderContract inject() => _AppointmentCommandProvider();

  Future<void> cancelAppointment(CancelAppointmentModel appointment);

}

enum AppointmentCommandProviderError {
  unauthorized,
  internalError,
}


class _AppointmentCommandProvider extends AppointmentCommandProviderContract {

  @override
  Future<dynamic> cancelAppointment(CancelAppointmentModel appointment) async {

    final response = await getIt<RepositoryManager>()
    .request(operation: RepositoryConstant.operationPost.key, endpoint: RepositoryPathConstant.cancelAppointment.path, 
    body: appointment.toJson())
    .catchError((onError) {

      return null;

    });

    return response;
  }
}