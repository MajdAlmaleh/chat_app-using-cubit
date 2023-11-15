import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        // login logic
        emit(LoginLoading());

        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(LoginFailure(errMessage: 'weak-password'));
          } else if (ex.code == 'email-already-in-use') {
            emit(LoginFailure(errMessage: 'email-already-in-use'));
          }
        } catch (ex) {
          print(ex);
          emit(LoginFailure(errMessage: 'something went wrong'));
        }
      } else if (event is RegisterEvent) {
        // register logic
        emit(ResgisterLoading());

        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          emit(ResgisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(ResgisterFailure(errMessage: 'weak-password'));
          } else if (ex.code == 'email-already-in-use') {
            emit(ResgisterFailure(errMessage: 'email-already-in-use'));
          }
        } catch (ex) {
          print(ex);
          emit(ResgisterFailure(errMessage: 'something went wrong'));
        }
      }
    });
  }
}
