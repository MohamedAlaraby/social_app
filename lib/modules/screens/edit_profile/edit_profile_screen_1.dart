import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/modules/widgets/default_TextFormField.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class EditScreen extends StatelessWidget {
   EditScreen({Key? key}) : super(key: key);
   var nameController = TextEditingController();
   var phoneController = TextEditingController();
   var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var userModel=SocialCubit.get(context).userModel;
        var cubit = SocialCubit.get(context);


        nameController.text=userModel!.name!;
        phoneController.text=userModel!.phone!;
        bioController.text=userModel!.bio!;

        return Scaffold(

          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.24,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
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
                                  image: NetworkImage('${cubit.userModel?.cover}'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 18,
                              child: IconButton(
                                onPressed: () {
                                  //pick cover image from the gallery.
                                  cubit.pickCoverImage();
                                },
                                icon: const Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor:
                              Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 46,
                                backgroundImage: NetworkImage('${cubit.userModel?.image}'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CircleAvatar(
                                radius: 15,
                                child: IconButton(
                                  onPressed: () {
                                    cubit.pickProfileImage();
                                  },
                                  icon: const Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
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
        );
      },
    );
  }
}
