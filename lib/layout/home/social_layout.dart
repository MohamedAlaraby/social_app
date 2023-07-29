import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/modules/screens/new_post/new_post_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

        if(state is SocialUploadNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
               cubit.titles[cubit.currentIndex],
            ),
            elevation: 0,
            actions: [
                IconButton(
                     icon: const Icon(IconBroken.Notification,) ,
                     onPressed:(){

                     },
                ),
              IconButton(
                icon: const Icon(IconBroken.Search,) ,
                onPressed:(){

                },
              ),

            ],

          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar:BottomNavigationBar(
            items: const[
              BottomNavigationBarItem(icon:Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Chat),label: 'Chats'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Plus),label: 'Post'),
              BottomNavigationBarItem(icon:Icon(IconBroken.User),label: 'Users'),
              BottomNavigationBarItem(icon:Icon(IconBroken.Setting),label: 'Settings'),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (index){
                 cubit.changeCurrentIndex(index);
            },

          ),
        );
      },
    );
  }
}
