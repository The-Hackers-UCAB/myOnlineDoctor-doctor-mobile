//Package imports
import 'dart:convert';

SignUpPatientDomainModel signUpDomainModelFromJson(String str) => SignUpPatientDomainModel.fromJson(json.decode(str));

String signUpDomainModelToJson(SignUpPatientDomainModel data) => json.encode(data.toJson());


///SigUnUpPatientDomainModel: Model for register a Patient
class SignUpPatientDomainModel {

  String email;
  String password;
  String role;
  String? confirmPassword;
  String? birthDate;

  SignUpPatientDomainModel({
    required this.email,
    required this.password,
    required this.role,
    this.confirmPassword,
    this.birthDate,
  });

  factory SignUpPatientDomainModel.fromJson(Map<String, dynamic> json) => SignUpPatientDomainModel(
    email: json["email"],
    password: json["password"],
    role: json["role"],
    confirmPassword: json["confirmPassword"],
    birthDate: json["birthDate"],
  );


  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "role": role,
    "confirmPassword": confirmPassword,
    "birthDate": birthDate,
  };



}