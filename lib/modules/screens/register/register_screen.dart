
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/social_layout.dart';
import 'package:social_app/modules/screens/login/login_screen.dart';
import 'package:social_app/modules/screens/register/cubit/register_cubit.dart';
import 'package:social_app/modules/screens/register/cubit/register_states.dart';
import 'package:social_app/modules/widgets/default_TextFormField.dart';
import 'package:social_app/modules/widgets/default_button.dart';
import 'package:social_app/shared/components.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailController   =TextEditingController();
  var passwordController=TextEditingController();
  var nameController    =TextEditingController();
  var phoneController   =TextEditingController();
  var formKey           = GlobalKey<FormState>();//to validate on the text form field.



  @override
  Widget build(BuildContext context) {

            return BlocProvider(
              create: (context) => RegisterCubit(),
              child: BlocConsumer<RegisterCubit,RegisterStates >(
                 listener: (context, state) {
                   if(state is CreateUserSuccessState){
                         navigateAndFinish(context,  LoginScreen());
                   }
                 },
                 builder: (context, state) {
                   var cubit=RegisterCubit.get(context);
                   return Scaffold(
                    appBar:AppBar(),
                    body: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'REGISTER',
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      color: Colors.black
                                  ),
                                ),
                                Text(
                                  'Register now to communicate with your friends',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey
                                  ),

                                ),
                                const SizedBox(height: 40.0),
                                DefaultTextFormField(
                                    controller: nameController,
                                    textInputType: TextInputType.name,
                                    validator: (string) {
                                      if(string!.isEmpty){
                                        return 'please enter the name';
                                      }
                                      return null;
                                    },
                                    label: 'Name',
                                    prefix: Icons.person
                                ),
                                const SizedBox(height: 16.0),
                                DefaultTextFormField(
                                    controller: emailController,
                                    textInputType: TextInputType.emailAddress,
                                    validator: (string) {
                                      if(string!.isEmpty){
                                        return 'please enter the email';
                                      }
                                      return null;
                                    },
                                    label: 'Email Address',
                                    prefix: Icons.email
                                ),
                                const SizedBox(height: 16.0),
                                DefaultTextFormField(
                                  controller: passwordController,
                                  textInputType: TextInputType.visiblePassword,
                                  validator: (string) {
                                    if(string!.isEmpty){
                                      return 'please enter the password';
                                    }
                                    return null;
                                  },
                                  label: 'Password',
                                  prefix: Icons.lock,
                                  isPassword: cubit.isPassword,
                                  suffix:IconButton(
                                    icon:Icon(cubit.suffix) ,
                                    onPressed: () {
                                      cubit.changePasswordVisibility();
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                DefaultTextFormField(
                                    controller: phoneController,
                                    textInputType: TextInputType.phone,
                                    validator: (string){
                                      if(string!.isEmpty){
                                        return 'please enter the phone';
                                      }
                                      return null;
                                    },
                                    label: 'Phone',
                                    prefix: Icons.phone
                                ),
                                const SizedBox(height: 16.0),
                                ConditionalBuilder(
                                  condition:state is! RegisterLoadingState,
                                  builder:(context) => DefaultButton(
                                      function:(){
                                        //validate to register the user.
                                        if(formKey.currentState!.validate()){
                                          cubit.registerUser(
                                            phone: phoneController.text,
                                            name: nameController.text,
                                            email: emailController.text,
                                            password:passwordController.text,
                                            context: context,
                                          );
                                        }
                                      },
                                      text: 'REGISTER'
                                  ),//DefaultButton
                                  fallback:(context) =>const Center(child: CircularProgressIndicator()) ,
                                ),
                                const SizedBox(
                                  height: 16.0,

                                ),
                                Row(
                                  children: [
                                    const Text('Already have an account?'),
                                    TextButton(
                                      child:const Text('Login') ,
                                      onPressed: () {
                                        navigateTo(context,LoginScreen());
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
                  );
                },
              ),
            );

  }
}
