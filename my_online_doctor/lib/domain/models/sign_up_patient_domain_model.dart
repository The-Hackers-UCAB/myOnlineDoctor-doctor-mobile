//Package imports
import 'dart:convert';

SignUpPatientDomainModel signUpDomainModelFromJson(String str) => SignUpPatientDomainModel.fromJson(json.decode(str));

String signUpDomainModelToJson(SignUpPatientDomainModel data) => json.encode(data.toJson());


///SigUnUpPatientDomainModel: Model for register a Patient
class SignUpPatientDomainModel {

  String email;
  String password;
  String role;

  SignUpPatientDomainModel({
    required this.email,
    required this.password,
    required this.role,
  });

  factory SignUpPatientDomainModel.fromJson(Map<String, dynamic> json) => SignUpPatientDomainModel(
    email: json["email"],
    password: json["password"],
    role: json["role"],
  );


  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "role": role,
  };



}