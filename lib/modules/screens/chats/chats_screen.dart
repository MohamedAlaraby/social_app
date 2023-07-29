import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/screens/chat_details/chat_details_screen.dart';
import 'package:social_app/modules/widgets/my_devider.dart';
import 'package:social_app/shared/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
          if(cubit.users.isEmpty){
              cubit.getAllUsers();
          }
          return  ConditionalBuilder(
            condition: cubit.users.isNotEmpty,
            fallback: (context) => const Center(child: CircularProgressIndicator(),),
            builder:(context) =>  Scaffold(
              body: ListView.separated(
                  itemBuilder:(context, index) =>buildChatItem(cubit.users[index],context),
                  separatorBuilder:(context, index) => const MyDivider(),
                  itemCount: cubit.users.length,
              ),
            ),
          );
      },
    );
  }

  Widget buildChatItem(UserModel user,BuildContext context) {
    return InkWell(
      onTap: () {
             navigateTo(context, ChatDetailsScreen(userModel: user));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:  [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                //user image
                user.image??'',
              ),
            ),
            const   SizedBox(
              width: 13,
            ),
            Text(
              user.name!,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 20,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
