///TextConstant: Enum for texts. All the apps texts are here.
enum TextConstant {
  appName,
  errorTimeoutConnection,
  errorInternetConnection,
  errorServer,
  errorLogin,
  errorUnauthorized,
  retry,
  acceptButton,
  cancelButton,
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

      default:
        return '';
    }
  }
}
