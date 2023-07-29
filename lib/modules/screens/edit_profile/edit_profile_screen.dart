import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/widgets/default_TextFormField.dart';
import 'package:social_app/modules/widgets/default_button.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatefulWidget {
  String? name;
  String? bio;
  String? phone;

  EditProfileScreen(this.name, this.bio, this.phone, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState(name, bio, phone);
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? name;
  String? bio;
  String? phone;

  _EditProfileScreenState(this.name, this.bio, this.phone);

  //You can not create the TextEditingController() inside the build function
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  UserModel? userModel;

  @override
  void initState() {
    super.initState();

    print("#################$name");
    print("#################$bio");
    print("#################$phone");
    nameController.text = name != null ? name! : "";
    bioController.text = bio != null ? bio! : "";
    phoneController.text = phone != null ? phone! : "";
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var cubit = SocialCubit.get(context);

    File? coverImage;
    File? profileImage;
    ImageProvider? profileBackGroundImage;
    ImageProvider? coverBackGroundImage;

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        coverImage = cubit.coverImage;
        profileImage = cubit.profileImage;
        userModel = cubit.userModel;
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            title: const Text('EditProfile'),
            actions: [
              TextButton(
                onPressed: () {
                  cubit.updateUserProfile(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                  );
                },
                child: const Text('Update'),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUpdateUserProfileLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Container(
                    height: screenHeight * 0.26,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                width: double.infinity,
                                height: screenHeight * 0.21,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImage != null
                                        ? FileImage(coverImage!)
                                        : NetworkImage(userModel!.cover!)
                                            as ImageProvider<Object>,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const CircleAvatar(
                                  radius: 18,
                                  child: Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                onPressed: () {
                                  //pick cover image from the gallery.
                                  cubit.pickCoverImage();
                                },
                              ),
                            ],
                          ),
                        ),
                        Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 46,
                                  backgroundImage: profileImage != null
                                      ? FileImage(profileImage!)
                                      : NetworkImage(userModel!.image!)
                                          as ImageProvider<Object>,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.pickProfileImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 18.0,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16.0,
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (profileImage != null || coverImage != null)
                    Row(
                      children: [
                        if (coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                DefaultButton(
                                  function: () {
                                    cubit.uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'Upload Cover',
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                if(state is SocialUploadCoverImageLoadingState)
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: LinearProgressIndicator(),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        if (profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                DefaultButton(
                                  function: () {
                                    cubit.uploadProfileImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioController.text,
                                    );
                                  },
                                  text: 'Upload Profile',
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                if(state is SocialUploadProfileImageLoadingState)
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: LinearProgressIndicator(),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (profileImage != null || coverImage != null)
                    const SizedBox(
                      height: 20,
                    ),
                  DefaultTextFormField(
                    controller: nameController,
                    textInputType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(height: 12),
                  DefaultTextFormField(
                    controller: bioController,
                    textInputType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'bio',
                    prefix: Icons.person,
                  ),
                  const SizedBox(height: 12),
                  DefaultTextFormField(
                    controller: phoneController,
                    textInputType: TextInputType.name,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    label: 'phone',
                    prefix: Icons.phone_android_outlined,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
