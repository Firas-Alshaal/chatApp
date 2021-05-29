import 'package:chat_app/modules/chat_app/social_login_screen/cubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({@required String email, @required String password}) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {

      emit(SocialLoginSuccessState(value.user.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;

    suffix = isPasswordShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(SocialChangePasswordVisibilityState());
  }
}
