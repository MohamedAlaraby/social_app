import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/screens/edit_profile/edit_profile_screen.dart';
import 'package:social_app/modules/screens/edit_profile/edit_profile_screen_1.dart';
import 'package:social_app/modules/screens/login/login_screen.dart';
import 'package:social_app/modules/widgets/default_TextFormField.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  var nameController=TextEditingController();

   SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {


        UserModel? userModel = SocialCubit.get(context).userModel;
        nameController.text=userModel!.name!;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: screenHeight * 0.24,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                          width: double.infinity,
                          height: screenHeight * 0.19,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${userModel?.cover}',
                              ),
                            ),
                          )),
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 46,
                        backgroundImage: NetworkImage(
                          "${userModel?.image}",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "${userModel?.name}",
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.3),
            ),
            Text(
              "${userModel?.bio}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey, height: 1.3, fontSize: 12),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '100',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(height: 1.3),
                          ),
                          Text(
                            'Post',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey, height: 1.3),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '265',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(height: 1.3),
                          ),
                          Text(
                            'Photo',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey, height: 1.3),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '10k',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(height: 1.3),
                          ),
                          Text(
                            'Follower',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey, height: 1.3),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text(
                            '0',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(height: 1.3),
                          ),
                          Text(
                            'Following',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey, height: 1.3),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                                navigateAndFinish(context, LoginScreen(),);
                          },
                        child: const Text('Sign out'),),),
                  const SizedBox(
                    width: 16,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(
                        context,
                         EditProfileScreen(
                          userModel.name,
                          userModel.bio,
                          userModel.phone,
                         ),
                      );
                    },
                    child: const Icon(
                      IconBroken.Edit,
                      size: 20,
                    ),

                  ),
                ],
              ),
            ),

          ],
        );
      },
    );
  }
}
