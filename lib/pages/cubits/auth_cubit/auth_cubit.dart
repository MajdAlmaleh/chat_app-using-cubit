import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/pages/cubits/chat_cubit/chat_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());









    Future<void> registerUser(
      {required String email, required String password}) async {
         emit(ResgisterLoading());
    try {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
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


    Future<void> loginUser(
      {required String email, required String password}) async {
         emit(LoginLoading());
    try {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
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
  }







}
