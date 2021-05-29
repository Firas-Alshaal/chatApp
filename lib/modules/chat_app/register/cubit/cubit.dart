import 'package:chat_app/models/social_app/social_user_model.dart';
import 'package:chat_app/modules/chat_app/register/cubit/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user.email);
      print(value.user.uid);
      userCreate(
          name: name, email: email, phone: phone, userId: value.user.uid);
      emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    @required String name,
    @required String email,
    @required String phone,
    @required String userId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      bio: "write your bio ..",
      image: "https://img.freepik.com/free-photo/horizontal-shot-handsome-charismatic-young-man-with-black-hair-stubble-posing-isolated-pointing-fore-fingers-having-confident-flirty-facial-expression-choosing-you-body-language_343059-4555.jpg?size=338&ext=jpg",
      cover: "https://img.freepik.com/free-photo/cheerful-positive-young-european-woman-with-dark-hair-broad-shining-smile-points-with-thumb-aside_273609-18325.jpg?size=338&ext=jpg",
      uId: userId,
      isEmailVerified: false,
    );
    emit(SocialCreateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(model.toJson())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;

    suffix = isPasswordShow
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
