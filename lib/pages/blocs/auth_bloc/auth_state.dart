part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

 class AuthInitial extends AuthState {}


class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

// ignore: must_be_immutable
class LoginFailure extends AuthState {
  String errMessage;
  LoginFailure({required this.errMessage});   
}
 class ResgisterInitial extends AuthState {}
class ResgisterLoading extends AuthState {}

class ResgisterSuccess extends AuthState {}

// ignore: must_be_immutable
class ResgisterFailure extends AuthState {
  String errMessage;
  ResgisterFailure({required this.errMessage});   
}

