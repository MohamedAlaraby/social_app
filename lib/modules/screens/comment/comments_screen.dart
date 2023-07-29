import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/screens/chat_details/chat_details_screen.dart';
import 'package:social_app/modules/widgets/my_devider.dart';
import 'package:social_app/shared/components.dart';

import '../../../models/comment_model.dart';

class CommentsScreen extends StatefulWidget {
  int postIndex;
  String commenterName;
  String commenterImage;

  CommentsScreen({
    super.key,
    required this.postIndex,
    required this.commenterName,
    required this.commenterImage,
  });

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  var commentController = TextEditingController();
  bool isButtonEnabled = false;
  bool isTextEmpty = true;
  @override
  void initState() {
    super.initState();
    SocialCubit.get(context).getPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          var commentsList = cubit.commentsList;
          return ConditionalBuilder(
            condition: cubit.postsList.isNotEmpty,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          buildCommentItem(context, index, commentsList[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: commentsList!.length,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                            controller: commentController,
                            onChanged: (String inputText) {
                              if (inputText.isEmpty) {
                                setState(() {
                                  isButtonEnabled = false;
                                });
                              } else {
                                setState(() {
                                  isButtonEnabled = true;
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
                          condition: state is! SocialCommentPostLoadingState,
                          fallback: (context) =>
                              const CircularProgressIndicator(),
                          builder: (context) => IconButton(
                            onPressed: () {
                              cubit.commentPost(
                                postId: SocialCubit.get(context)
                                    .postsIds[widget.postIndex],
                                comment: commentController.text,
                                commenterName: widget.commenterName,
                                commenterImage: widget.commenterImage,
                              );
                              setState(() {});
                              commentController.text = '';
                            },
                            icon: Icon(Icons.send,
                                color: isButtonEnabled == true
                                    ? Colors.blue
                                    : Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCommentItem(context, index, CommentModel comment) {
    var cubit = SocialCubit.get(context);

    return Container(
      padding: const EdgeInsets.all(7),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(
                    comment.commenterImage ?? '',
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.commenterName ?? '',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,

                          ),
                        ),
                        Text(
                          comment.comment ?? '',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,

                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
