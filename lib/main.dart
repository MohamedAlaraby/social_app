import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/social_layout.dart';
import 'package:social_app/modules/screens/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/network/local/CacheHelper.dart';
import 'package:social_app/shared/styles/themes.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());

  makeToast(message: 'on background message',toastState: ToastStates.SUCCESS,);
}


void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyBlocObserver();
    await Firebase.initializeApp();
    await CacheHelper.init();
    late Widget startWidget;


   var token=await FirebaseMessaging.instance.getToken();
    print("firebase messaging token is $token");
   //if the app is in the opened(in the foreground)
    FirebaseMessaging.onMessage.listen((event) {
      print("The data you passed are ${event.data.toString()}");
      makeToast(message: "onMessage", toastState: ToastStates.SUCCESS);
    });
    //if we press on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("onMessageOpenedApp  ${event.data.toString()}");
      makeToast(message: "onMessageOpenedApp", toastState: ToastStates.SUCCESS);
    });
    //if the app is closed or in the background
     FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);






    uId = CacheHelper.getData(key: 'uId');

    print("### the user id is $uId");
    if(uId  !=  null){
       startWidget = const SocialLayout();
    }else{
      startWidget = LoginScreen();
    }
    runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp(this.startWidget, {super.key});



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => SocialCubit()
        ..getUserData()
        ..getAllUsers()
        ..getPosts(),
      child: MaterialApp(
        home: startWidget,
        debugShowCheckedModeBanner: false,
        title: 'Social App',
        theme:lightTheme,
      ),
    );

  }
}
