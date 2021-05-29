import 'package:chat_app/lauout/chat_app/social_layout.dart';
import 'package:chat_app/modules/chat_app/register/cubit/cubit.dart';
import 'package:chat_app/modules/chat_app/register/cubit/state.dart';
import 'package:chat_app/shared/Components/component.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
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
                        Text('REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black)),
                        Text('Register Now To Communicate With Your Friends',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey)),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Input your Name';
                              } else
                                return null;
                            },
                            label: 'User Name',
                            prefix: Icons.person,
                            theme: Theme.of(context).textTheme.bodyText1,
                            colorIcon: Theme.of(context).iconTheme.color),
                        SizedBox(
                          height: 15.0,
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
                                SocialRegisterCubit.get(context).isPasswordShow,
                            type: TextInputType.visiblePassword,
                            suffix: SocialRegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              SocialRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: (value) {},
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
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Input your Phone';
                              } else
                                return null;
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                            theme: Theme.of(context).textTheme.bodyText1,
                            colorIcon: Theme.of(context).iconTheme.color),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'register',
                              isUpperCase: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
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
