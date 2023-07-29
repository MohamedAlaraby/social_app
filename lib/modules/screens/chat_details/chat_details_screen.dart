import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/widgets/my_devider.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class ChatDetailsScreen extends StatefulWidget {
  UserModel userModel;

  ChatDetailsScreen({required this.userModel, Key? key}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  bool isTextIsEmpty = true;
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context)
            .getAllMessages(receiverId: widget.userModel.uID ?? "");
        return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SocialCubit.get(context);

              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                          //user image
                          widget.userModel.image ?? '',
                        ),
                      ),
                      const SizedBox(
                        width: 13,
                      ),
                      Text(
                        widget.userModel.name ?? "",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                body:  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 2),
                        Expanded(
                          child: ConditionalBuilder(
                            condition: cubit.messages.isNotEmpty,
                            fallback: (context) => const Center(child: Text('There is not any message yet')),
                            builder: (context) =>ListView.separated(
                              itemBuilder: (context, index) {
                                var message=  cubit.messages[index];
                                if(message.senderId == cubit.userModel!.uID){
                                  //my message
                                  return buildMyMessage(message);
                                }else{
                                  return buildMessage(message);
                                }
                              } ,
                              separatorBuilder: (context, index) => const SizedBox(height: 16,),
                              itemCount: cubit.messages.length,

                            ),
                        ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: messageController,
                                  onChanged: (String inputText) {
                                    if (inputText.isEmpty) {
                                      setState(() {
                                        isTextIsEmpty = true;
                                      });
                                    } else {
                                      setState(() {
                                        isTextIsEmpty = false;
                                      });
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Write your message here...',
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ),
                              ConditionalBuilder(
                                condition:
                                    state is! SocialSendMessageLoadingState,
                                fallback: (context) =>
                                    const CircularProgressIndicator(),
                                builder: (context) => IconButton(
                                  onPressed: () {
                                    cubit.sendMessage(
                                      message: messageController.text,
                                      receiverId: widget.userModel.uID ?? '',
                                      timestamp:Timestamp.fromDate(DateTime.now()),
                                    );
                                    messageController.text = "";
                                  },
                                  icon: Icon(Icons.send,
                                      color: isTextIsEmpty == true
                                          ? Colors.grey
                                          : Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

              );

            }
            );
      },
    );
  }

  //on the left message(the other side)
  Widget buildMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(6),
            topEnd: Radius.circular(6),
            topStart: Radius.circular(6),
          ),
          color: Colors.grey[300],
        ),
        child:  Padding(
          padding:const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Text(messageModel.message!),
        ),
      ),
    );
  }

  //on the right message(my side)
  Widget buildMyMessage(MessageModel messageModel) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadiusDirectional.only(
            bottomStart: Radius.circular(6),
            topEnd: Radius.circular(6),
            topStart: Radius.circular(6),
          ),
          color: defaultColor[100],
        ),
        child:  Padding(
          padding:const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          child: Text(messageModel.message!),
        ),
      ),
    );
  }
}
