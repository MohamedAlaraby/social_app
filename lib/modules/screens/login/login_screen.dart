import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/social_layout.dart';
import 'package:social_app/modules/screens/login/cubit/login_cubit.dart';
import 'package:social_app/modules/screens/register/register_screen.dart';
import 'package:social_app/modules/widgets/default_TextFormField.dart';
import 'package:social_app/modules/widgets/default_button.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/network/local/CacheHelper.dart';

import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            makeToast(
              message: state.error,
              toastState: ToastStates.ERROR,
            );
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
                key:"uId",
                value: state.uId
            ).then((value){

              navigateAndFinish(context,const SocialLayout());
              uId=CacheHelper.getData(
                  key:"uId",
              );
              print(" ## The saved user id is $uId");
            }).catchError((error) {
              print(" ## error is $error");
            }
            );


          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return BlocConsumer<LoginCubit, LoginStates>(
            listener: (context, state) {},
            builder: (context, state) =>
                Scaffold(
                  appBar: AppBar(),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'LOGIN',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headlineMedium?.copyWith(
                                        color: Colors.black
                                    )
                              ),
                              Text(
                                'Login now to communicate with your friends',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium?.copyWith(
                                    color: Colors.grey
                                )
                              ),
                              const SizedBox(height: 40.0),
                              DefaultTextFormField(
                                  controller: emailController,
                                  textInputType: TextInputType.emailAddress,
                                  validator: (string) {
                                    if (string!.isEmpty) {
                                      return 'please enter the email';
                                    }
                                    return null;
                                  },
                                  label: 'Email',
                                  prefix: Icons.email),
                              const SizedBox(height: 16.0),
                              DefaultTextFormField(
                                controller: passwordController,
                                textInputType: TextInputType.visiblePassword,
                                validator: (string) {
                                  if (string!.isEmpty) {
                                    return 'please enter the password';
                                  }
                                  return null;
                                },
                                label: 'Password',
                                prefix: Icons.lock,
                                onFieldSubmitted: (string) {
                                  //validate to login the user.
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).loginUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context,
                                    );
                                  }
                                },
                                isPassword: LoginCubit
                                    .get(context)
                                    .isPassword,
                                suffix: IconButton(
                                  icon: Icon(LoginCubit
                                      .get(context)
                                      .suffix),
                                  onPressed: () {
                                    LoginCubit.get(context)
                                        .changePasswordVisibility();
                                  },
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              ConditionalBuilder(
                                condition: state is! LoginLoadingState,

                                builder: (context) =>
                                    DefaultButton(
                                        function: () {
                                          //validate to login the user.
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.loginUser(
                                                email: emailController.text,
                                                password: passwordController.text,
                                                context: context
                                            );
                                          }
                                        },
                                        text: 'LOGIN'
                                    ), //DefaultButton
                                fallback: (context) =>
                                const Center(
                                    child: CircularProgressIndicator()
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  const Text('Don\'t have an account?'),
                                  TextButton(
                                    child: const Text('register'),
                                    onPressed: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
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
