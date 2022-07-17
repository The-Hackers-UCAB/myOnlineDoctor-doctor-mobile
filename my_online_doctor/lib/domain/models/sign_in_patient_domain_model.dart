//Package imports
import 'dart:convert';

SignInPatientDomainModel signUpDomainModelFromJson(String str) => SignInPatientDomainModel.fromJson(json.decode(str));

String signUpDomainModelToJson(SignInPatientDomainModel data) => json.encode(data.toJson());


///SigInUpPatientDomainModel: Model for login a Patient

class SignInPatientDomainModel {
  String email;
  String password;


  SignInPatientDomainModel({
    required this.email,
    required this.password,
  });


  factory SignInPatientDomainModel.fromJson(Map<String, dynamic> json) => SignInPatientDomainModel(
    email: json["email"],
    password: json["password"],
  );


  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };


}