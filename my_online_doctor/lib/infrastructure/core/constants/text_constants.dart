///TextConstant: Enum for texts. All the apps texts are here.
enum TextConstant {
  appName,
  errorTimeoutConnection,
  errorInternetConnection,
  errorServer,
  errorUnauthorized,
  retry,
  acceptButton,
  cancelButton,
  successTitle,
  errorTitle,
  failedRegister,
  successRegister,
  termsAndConditionsNotSelected,
  passwordNotMatch,
  birthDateInvalid,
  errorFormValidation,
  signIn,
  signUp,
  forgotMyPassword,
  toBeContinued,
  pageInConstruction,
  sorry,
  expiredCookie,
  requestAppointment,
  appointmentTitle,
  cancelAppointment,

}

extension TextConstantExtension on TextConstant {
  String get text {
    switch (this) {
      case TextConstant.appName:
        return 'My Online Doctor';
      case TextConstant.errorTimeoutConnection:
        return 'La operación esta tomando mucho tiempo en completarse.\nPor favor, verifique su conexión de internet';

      case TextConstant.errorInternetConnection:
        return 'No se ha podido realizar la conexión con el servidor.\nPor favor, intente más tarde';

      case TextConstant.errorServer:
        return 'Error procesando operación.\nPor favor, intente más tarde';

      case TextConstant.errorUnauthorized:
        return 'Credenciales inválidas';

      case TextConstant.retry:
        return 'Intentar de nuevo';

      case TextConstant.acceptButton:
        return 'Aceptar';

      case TextConstant.cancelButton:
        return 'Cancelar';

      case TextConstant.successTitle:
        return 'Éxito';

      case TextConstant.errorTitle:
        return 'Error';

      case TextConstant.failedRegister:
        return 'No se ha podido registrar al paciente';

      case TextConstant.successRegister:
        return 'Se ha registrado al paciente';

      case TextConstant.termsAndConditionsNotSelected:
        return 'Debe aceptar los términos y condiciones';

      case TextConstant.passwordNotMatch:
        return 'Las contraseñas no coinciden';

      case TextConstant.birthDateInvalid:
        return 'El paciente debe tener al menos 18 años de edad';

      case TextConstant.errorFormValidation:
        return 'Por favor, ingrese todos los datos requeridos';

      case TextConstant.signIn:
        return 'Iniciar sesión';
      
      case TextConstant.signUp:
        return 'Registrarse';

      case TextConstant.forgotMyPassword:
        return 'Olvidé mi contraseña';

      case TextConstant.toBeContinued:
        return 'Próximamente';

      case TextConstant.pageInConstruction:
        return 'Página en construcción';

      case TextConstant.sorry:
        return 'Lo sentimos';

      case TextConstant.expiredCookie:
        return 'La sesión ha expirado. Por favor vuelva a ingresar';

      case TextConstant.requestAppointment:
        return 'Solicitar cita';

      case TextConstant.appointmentTitle:
        return 'Citas Médica';

      case TextConstant.cancelAppointment:
        return 'Cancelar cita';


    }
  }
}
