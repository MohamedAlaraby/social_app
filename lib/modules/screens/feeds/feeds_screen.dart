import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/home/cubit/cubit.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/screens/comment/comments_screen.dart';
import 'package:social_app/modules/widgets/my_devider.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/constants.dart';
import 'package:social_app/shared/styles/colors.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatefulWidget {
  FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();

}

class _FeedsScreenState extends State<FeedsScreen>{
  var commentController = TextEditingController();
  bool isButtonEnabled = false;

  bool isPostLiked=false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var cubit = SocialCubit.get(context);

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {

        return ConditionalBuilder(
          condition: cubit.postsList.isNotEmpty && cubit.userModel != null &&state is! SocialGetPostsLoadingState,
          fallback: (context) =>const Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 6.0,
                  margin: const EdgeInsets.all(12.0),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Image(
                        image:
                        NetworkImage(
                          imageUrl,
                        ),
                        width: double.infinity,
                        height: screenHeight * 0.30,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'communicate with your friends',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildPostItem(context, cubit.postsList[index], index);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 0,
                  ),
                  itemCount: cubit.postsList.length,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(context, PostModel? post, int? index) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var cubit = SocialCubit.get(context);

    return ConditionalBuilder(
      condition: post != null,
      fallback:(context) =>const Center(child: CircularProgressIndicator()),
      builder:(context) {
        return  Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 6.0,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        //user image
                        post!.image ?? ' ',
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                post.name ?? ' ',
                                style: const TextStyle(
                                  height: 1.3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Center(
                                  child: Icon(
                                    Icons.check_circle,
                                    color: defaultColor,
                                    size: 20,
                                  ),
                              ),
                            ],
                          ),
                          Text(
                            post.postDateTime ?? ' ',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                                height: 1.3, color: Colors.grey[500], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(5),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const MyDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    post.postText ?? ' ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                ),
                //tags container
                Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Container(
                        height: 20,
                        child: MaterialButton(
                          minWidth: 1.0,
                          //only take width equal to the required.
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            "#Software",
                            style: TextStyle(
                              color: defaultColor,
                              height: 1,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        height: 20,
                        child: MaterialButton(
                          minWidth: 1.0,
                          //only take width equal to the required.
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: const Text(
                            "#Flutter",
                            style: TextStyle(
                              color: defaultColor,
                              height: 1,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (post.postImage! != " ")
                  Container(
                      width: double.infinity,
                      height: screenHeight * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            post.postImage!,
                          ),
                        ),
                      ),),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              size: 20,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (SocialCubit.get(context).likesList != null&&
                                SocialCubit.get(context).likesList!.isNotEmpty)
                              Text(
                                SocialCubit.get(context)
                                    .likesList![index!]
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                IconBroken.Chat,
                                size: 20,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              if (SocialCubit.get(context).commentsNoList!.isNotEmpty)
                                Text(
                                  SocialCubit.get(context)
                                      .commentsNoList![index!]
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                            ],
                          ),
                        )),
                  ],
                ),
                const MyDivider(),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                              SocialCubit.get(context).userModel?.image ?? '',
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                navigateTo(context, CommentsScreen(
                                  postIndex:index!,
                                  commenterImage: SocialCubit.get(context).userModel?.image ?? '',
                                  commenterName: SocialCubit.get(context).userModel?.name ?? '',
                                ));
                              },
                              child: const Text(
                                  "Write a comment...",
                                style: TextStyle(fontSize: 13,color: Colors.grey) ,
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context).likePost(
                            postId: SocialCubit.get(context).postsIds[index!]);
                            isPostLiked= !isPostLiked;
                      },

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: const [
                            Icon(
                              IconBroken.Heart,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              'Like',
                              style: TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
