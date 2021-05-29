import 'package:chat_app/lauout/chat_app/social_layout.dart';
import 'package:chat_app/modules/chat_app/register/social_register.dart';
import 'package:chat_app/modules/chat_app/social_login_screen/cubit/cubit.dart';
import 'package:chat_app/modules/chat_app/social_login_screen/cubit/state.dart';
import 'package:chat_app/shared/Components/component.dart';
import 'package:chat_app/shared/network/local/cache_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLogin extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndFinish(context, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: Colors.black)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Login Now To Communicate With Your Friends',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey)),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Input Email Address';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined,
                            theme: Theme.of(context).textTheme.bodyText1,
                            colorIcon: Theme.of(context).iconTheme.color),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            isPassword:
                                SocialLoginCubit.get(context).isPasswordShow,
                            type: TextInputType.visiblePassword,
                            suffix: SocialLoginCubit.get(context).suffix,
                            suffixPressed: () {
                              SocialLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Input your password';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock_outline,
                            theme: Theme.of(context).textTheme.bodyText1,
                            colorIcon: Theme.of(context).iconTheme.color),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'login',
                              isUpperCase: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'If You Don`t Have an Account',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            defaultTextButton(
                                function: () {
                                  navigateTo(context, SocialRegisterScreen());
                                },
                                text: 'Register Now'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
