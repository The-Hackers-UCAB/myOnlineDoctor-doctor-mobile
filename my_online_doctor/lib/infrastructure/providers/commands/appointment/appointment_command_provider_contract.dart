import 'package:my_online_doctor/domain/models/appointment/accept_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/cancel_appointment_model.dart';
import 'package:my_online_doctor/domain/models/appointment/reject_appointment_model.dart';
import 'package:my_online_doctor/infrastructure/core/constants/repository_constants.dart';
import 'package:my_online_doctor/infrastructure/core/injection_manager.dart';
import 'package:my_online_doctor/infrastructure/core/repository_manager.dart';

abstract class AppointmentCommandProviderContract {
  static AppointmentCommandProviderContract inject() => _AppointmentCommandProvider();

  Future<void> cancelAppointment(CancelAppointmentModel appointment);

  Future<void> rejectAppointment(RejectAppointmentModel appointment);

  Future<void> acceptAppointment(AcceptAppointmentModel appointment);

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

  @override
  Future<dynamic> rejectAppointment(RejectAppointmentModel appointment) async {

    final response = await getIt<RepositoryManager>()
    .request(operation: RepositoryConstant.operationPost.key, endpoint: RepositoryPathConstant.rejectAppointment.path, 
    body: appointment.toJson())
    .catchError((onError) {

      return null;

    });

    return response;
  }



  @override
  Future<dynamic> acceptAppointment(AcceptAppointmentModel appointment) async {

    final response = await getIt<RepositoryManager>()
    .request(operation: RepositoryConstant.operationPost.key, endpoint: RepositoryPathConstant.acceptAppointment.path, 
    body: appointment.toJson())
    .catchError((onError) {

      return null;

    });

    return response;
  }

}