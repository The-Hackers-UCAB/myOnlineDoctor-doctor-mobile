import 'package:flutter/material.dart';


const double marginLat = 16.0;
const double marginTop = 8.0;
const EdgeInsets generalMarginView = EdgeInsets.only(left: marginLat, right: marginLat, top: marginTop, bottom: marginTop);


///MinMaxConstant: Enum for Min or Max for inputs
enum MinMaxConstant {
  minLengthEmail,
  maxLengthEmail,
  minLengthName,
  maxLengthName,
  minLengthPassword,
  maxLengthPassword,
  minLengthPhone,
  maxLengthPhone,

}

extension MinMaxConstantExtension on MinMaxConstant {

  int get value {

    switch(this) {
      case MinMaxConstant.minLengthEmail:
        return 5;

      case MinMaxConstant.maxLengthEmail:
        return 255;

      case MinMaxConstant.minLengthName:
        return 3;

      case MinMaxConstant.maxLengthName:
        return 20;

      case MinMaxConstant.minLengthPassword:
        return 6;

      case MinMaxConstant.maxLengthPassword:
        return 12;
      
      case MinMaxConstant.minLengthPhone:
        return 7;

      case MinMaxConstant.maxLengthPhone:
        return 7;

    }
  }

}



/// ImagesConstant: Enum for images.
enum ImagesConstant {
  logo,
  serverError,
  noInternet,
  noProfilePhoto,
  noDoctorFound,
}

const imageBase= 'assets/images/';

extension ImagesConstantExtension on ImagesConstant {
  String get image {
    switch (this) {
      case ImagesConstant.logo:
        return 'assets/icon/doctor_logo.png';

      case ImagesConstant.serverError:
        return '${imageBase}server_error.png';

      case ImagesConstant.noProfilePhoto:
        return '${imageBase}no_profile_photo.png';

      case ImagesConstant.noDoctorFound:
        return '${imageBase}no_doctor_found.png';

      case ImagesConstant.noInternet:
        return '${imageBase}no_internet.jpg';
    }
  }
}




///RepositorysConstant: Enum for repositories methods.
enum RepositoryConstant {
  contentType,
  operationGet,
  operationPost,
  operationPut,
  operationDelete,
}

extension RepositoryConstantExtension on RepositoryConstant {

  String get key {
    switch (this) {
      case RepositoryConstant.contentType:
        return 'application/json';
      case RepositoryConstant.operationGet:
        return 'get';
      case RepositoryConstant.operationPost:
        return 'post';
      case RepositoryConstant.operationPut:
        return 'put';
      case RepositoryConstant.operationDelete:
        return 'delete';
    }
  }
}


///RepositoryPathConstant: Enum for endpoints path.
enum RepositoryPathConstant {
  register,
  login,
}

extension RepositoryPathConstantExtension on RepositoryPathConstant {

  String get path {

    switch (this) {
      case RepositoryPathConstant.register:
        return '';

      case RepositoryPathConstant.login:
        return '';
    }
  }
}



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
