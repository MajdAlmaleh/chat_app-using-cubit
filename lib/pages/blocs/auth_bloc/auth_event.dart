part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}


class LoginEvent extends AuthEvent{

String email;
String password;
LoginEvent({required this.email,required this.password});



}

class RegisterEvent extends AuthEvent{


String email;
String password;
RegisterEvent({required this.email,required this.password});




}
