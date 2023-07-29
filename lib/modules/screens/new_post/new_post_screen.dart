import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/layout/home/social_layout.dart';
import 'package:social_app/modules/screens/feeds/feeds_screen.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
   NewPostScreen({Key? key}) : super(key: key);
  var postTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit=SocialCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(IconBroken.Arrow___Left_2),
        ),
        title: const Text('New Post'),
        actions: [
          TextButton(
            onPressed: () {
              var now=DateTime.now();
              if(cubit.postImage==null){
                  cubit.createPost(
                      postText: postTextController.text,
                      postDateTime: now.toString(),
                  );
                  print("the post image is null");
              }else{

                cubit.uploadPostImage(
                  postText: postTextController.text,
                  postDateTime: now.toString(),
                );
                print("the post image is null");
              }

            },
            child: const Text("POST"),
          ),
        ],
      ),
      body: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
             if(state is SocialCreatePostSuccessState ){
                 navigateAndFinish(context, const SocialLayout());
             }
        },
        builder: (context, state) {
          var screenHeight= MediaQuery.of(context).size.height;
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              height: screenHeight*0.85,
              child: Column(
                children: [
                  if(state is SocialUploadPostImageLoadingState   || state is SocialCreatePostLoadingState )
                  const LinearProgressIndicator(),

                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          avatar1,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Text(
                        'Mohamed Elaraby',
                        style: TextStyle(
                          height: 1.3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),


                  Expanded(
                    child: TextFormField(
                      controller: postTextController,
                      decoration: const InputDecoration(
                        hintText: 'What is in your mind?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if(cubit.postImage!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: screenHeight * 0.5,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(5 ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:FileImage(cubit.postImage!)
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const CircleAvatar(
                          radius: 18,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        onPressed: ()  {
                          //pick cover image from the gallery.
                           cubit.closePickPostImage();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                             cubit.pickPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 16,
                              ),
                              Text('Add photos')
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('###tags'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
