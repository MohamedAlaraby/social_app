import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/home/cubit/states.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/screens/chats/chats_screen.dart';
import 'package:social_app/modules/screens/feeds/feeds_screen.dart';
import 'package:social_app/modules/screens/new_post/new_post_screen.dart';
import 'package:social_app/modules/screens/settings/settings_screen.dart';
import 'package:social_app/modules/screens/users/users_screen.dart';
import 'package:social_app/shared/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserDataProfileLoadingState());
    FirebaseFirestore.instance
        .collection("users") //gate 1
        .doc(uId) //gate 2
        .get() //gate 3
        .then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      profileImage = null;
      coverImage = null;
      emit(SocialGetUserDataProfileSuccessState());
    }).catchError((error) {
      emit(SocialGetUserDataProfileErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    if (index == 2) {
      emit(SocialUploadNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  List<Widget> screens = [
    FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles = [
    "Home",
    "Chats",
    "New Post",
    "Users",
    "Settings",
  ];
  var picker = ImagePicker();
  File? profileImage;
  File? coverImage;
  File? postImage;

  Future<void> pickProfileImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialPickProfileImageSuccessState());
    } else {
      print("no image selected");
      emit(SocialPickProfileImageSuccessState());
    }
  }

  Future<void> pickCoverImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialPickCoverImageSuccessState());
    } else {
      print("no image selected");
      emit(SocialPickCoverImageSuccessState());
    }
  }

  Future<void> pickPostImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPickPostImageSuccessState());
    } else {
      print("no image selected");
      emit(SocialPickPostImageSuccessState());
    }
  }

  void closePickPostImage() {
    postImage = null;
    emit(SocialClosePickPostImageState());
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUploadProfileImageLoadingState());
    print("profile image is $profileImage");
    if (profileImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child("users/${Uri.file(profileImage!.path).pathSegments.last}")
          .putFile(profileImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateUserProfile(name: name, phone: phone, bio: bio, image: value);
          print("success get the url of the profile image and it is :$value");
        }).catchError((error) {
          print(
              "error when getting the download url which contain the link to our profile image $error");
          emit(SocialUploadProfileImageErrorState());
        });
      }).catchError((error) {
        print("the error occurd when uploading the profile image is $error");
        emit(SocialUploadProfileImageErrorState());
      });
    } else {
      print("sorry the image is null");
    }
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUploadCoverImageLoadingState());
    if (coverImage != null) {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child("users/${Uri.file(coverImage!.path).pathSegments.last}")
          .putFile(coverImage!)
          .then((value) {
        value.ref.getDownloadURL().then((value) {
          updateUserProfile(name: name, phone: phone, bio: bio, cover: value);
          print("success get the url of the cover image and it is :$value");
        }).catchError((error) {
          print(
              "error when getting the download url which contain the link to our cover image $error");
          emit(SocialUploadCoverImageErrorState());
        });
      }).catchError((error) {
        print("the error occurred when uploading the cover image is $error");
        emit(SocialUploadCoverImageErrorState());
      });
    } else {
      print("sorry the image is null");
    }
  }

  void updateUserProfile({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    if (userModel != null) {
      UserModel model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        image: image ?? userModel!.image,
        cover: cover ?? userModel!.cover,
        uID: userModel!.uID,
        email: userModel!.email,
      );
      FirebaseFirestore.instance
          .collection("users")
          .doc(userModel!.uID!)
          .update(model.toMap())
          .then((value) {
        getUserData();
      }).catchError((error) {
        emit(SocialUpdateUserProfileErrorState());
      });
    }
  }

  //create post
  void uploadPostImage({
    required String postText,
    required String? postDateTime,
  }) {
    emit(SocialUploadPostImageLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((TaskSnapshot value) {
      value.ref.getDownloadURL().then((value) {
        //here we should upload post to our database
        createPost(
          postText: postText,
          postDateTime: postDateTime,
          //here the value is the url of the uploaded image we just uploaded it now.
          postImage: value,
        );
        emit(SocialUploadPostImageSuccessState());
        print(
            "success when uploading post image (inner)creating a post :$value");
      }).catchError((error) {
        print("error when creating a post $error");
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error) {
      print("the error occurred when  uploading post image  (outer)is $error");
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createPost({
    required String postText,
    required String? postDateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      image: userModel!.image,
      uID: userModel!.uID,
      name: userModel!.name,
      postText: postText,
      postImage: postImage ?? ' ',
      postDateTime: postDateTime,
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toMap())
        .then((value) {
      getPosts();
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  PostModel? postModel;

  List<PostModel> postsList = [];
  List<String> postsIds = [];
  List<int?>? likesList = [];
  List<CommentModel>? commentsList = [];
  List<int?>? commentsNoList = [];
  List<String?>? commentsTextList = [];

  void getPosts() {
    postsList = [];
    likesList = [];
    postsIds = [];
    commentsNoList = [];
    commentsTextList = [];
    commentsList = [];

    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection("posts") //gate 1
        .get() //gate 2
        .then((value) {
      //value is the list of posts
      value.docs.forEach((post) {
        postsList.add(PostModel.fromJson(post.data()));
        postsIds.add(post.id);
        print("all posts are $postsList");
        print("posts ids are $postsIds");

        post.reference.collection('likes').get().then((value) {
          //here i catch the likes collection
          likesList?.add(value.docs.length);
          SocialGetLikesSuccessState();
        });

        post.reference.collection('comments').get().then((value) {
          value.docs.forEach((element)
          {
            print("@@@@@@@@@the comment map data is ${element.data()}");
            commentsList?.add(CommentModel.fromJson(element.data()));
          });
          commentsNoList?.add(value.docs.length);
          print("comments number for each post list are $commentsNoList");
          emit(SocialGetCommentsSuccessState());
        });
      } //end of foreach
          );

      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uID)
        .set({'like': true}).then((value) {
      emit(SocialSuccessLikePostState());
    }).catchError((error) {
      emit(SocialErrorLikePostState());
    });
  }

  void commentPost({
    required String postId,
    required String comment,
    required String commenterName,
    required String commenterImage,
  }) {
    emit(SocialCommentPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
            'comment': comment,
            'commenterName': commenterName,
            'commenterImage': commenterImage,
       }).then((value) {
      getPosts();
      emit(SocialSuccessCommentPostState());
    }).catchError((error) {
      emit(SocialErrorCommentPostState());
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((user) {
        if (user.data()["uID"] != userModel!.uID) {
          //I want all users except me.
          users.add(UserModel.fromJson(user.data()));
        }
      });

      emit(SocialGetAllUsersSuccessState());
    }).catchError((error) {
      emit(SocialGetAllUsersErrorState(error.toString()));
      print(error.toString());
    });
  }

  //chat details screen.
  MessageModel? messageModel;

  void sendMessage({
    required String message,
    required String receiverId,
    required Timestamp timestamp,
  }) {
    emit(SocialSendMessageLoadingState());
    if (userModel != null) {
      messageModel = MessageModel(
        message: message,
        timestamp: timestamp,
        receiverId: receiverId,
        senderId: userModel?.uID ?? "",
      );

      //store the message in the sender side
      FirebaseFirestore.instance
          .collection("users")
          .doc(userModel?.uID)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(messageModel!.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessState());
      }).catchError((error) {
        emit(SocialSendMessageErrorState(error));
      });
      //store the message in the receiver side
      FirebaseFirestore.instance
          .collection("users")
          .doc(receiverId)
          .collection('chats')
          .doc(userModel!.uID)
          .collection('messages')
          .add(messageModel!.toMap())
          .then((value) {
        emit(SocialSendMessageSuccessState());
      }).catchError((error) {
        emit(SocialSendMessageErrorState(error));
      });
    }
  }

  List<MessageModel> messages = [];

  void getAllMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uID)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((value) {
        messages.add(MessageModel.fromJson(value.data()));
      });
      emit(SocialGetAllMessagesSuccessState());
    });
  }
} //end of class
