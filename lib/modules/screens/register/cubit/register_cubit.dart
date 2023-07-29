import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/screens/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required BuildContext context,
  }) {
    print('hello');
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user?.email.toString());
      print(value.user?.uid.toString());


      createUser(
          name: name,
          email: email,
          phone: phone,
          uID: value.user!.uid,
        context: context
      );
    }).catchError((error) {
      print('the error is $error');
      emit(RegisterErrorState(error.toString()));
    });
  }

  void createUser({
    required String name,
    required String email,
    required String phone,
    required String uID,
    required BuildContext context,
  }) {
    emit(CreateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uID: uID,
      image: 'https://img.freepik.com/free-vector/person-holding-blank-banner_23-2148086037.jpg?w=740&t=st=1688622630~exp=1688623230~hmac=593b166752203ac764ad693293a64de6e439a6a698b758a8af14e3d5617d407a',
      cover: 'https://img.freepik.com/premium-vector/woman-working-laptop-drinking-coffee_311865-7499.jpg?w=740',
      bio: 'Hello, I am Mohamed. I am a Flutter developer.',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uID)
        .set(model.toMap())
        .then((value) {
             emit(CreateUserSuccessState());
             SocialCubit.get(context).getUserData();
       }).catchError((error) {
           emit(CreateUserErrorState(error.toString()));
       });
  }

  IconData suffix = Icons.visibility;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }


}
