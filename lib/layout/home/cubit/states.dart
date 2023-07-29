abstract class SocialStates{}


class SocialInitialState extends SocialStates{}

class SocialGetUserDataProfileSuccessState extends SocialStates{}
class SocialGetUserDataProfileErrorState extends   SocialStates{
  final String error;
  SocialGetUserDataProfileErrorState(this.error);
}
class SocialGetUserDataProfileLoadingState extends SocialStates{}

class SocialChangeBottomNavState extends SocialStates{}
//for the bottom app bar
class SocialUploadNewPostState extends SocialStates{}

class SocialPickProfileImageSuccessState extends SocialStates{}
class SocialPickProfileImageErrorState extends SocialStates{}


class SocialPickCoverImageSuccessState extends SocialStates{}
class SocialPickCoverImageErrorState extends SocialStates{}



class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}
class SocialUploadCoverImageLoadingState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}
class SocialUploadProfileImageLoadingState extends SocialStates{}

class SocialUpdateUserProfileErrorState extends SocialStates{}
class SocialUpdateUserProfileLoadingState extends SocialStates{}

class SocialCreatePostLoadingState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostErrorState     extends   SocialStates{}

class SocialUploadPostImageLoadingState extends SocialStates{}
class SocialUploadPostImageSuccessState extends SocialStates{}
class SocialUploadPostImageErrorState     extends   SocialStates{}

class SocialPickPostImageSuccessState extends SocialStates{}
class SocialPickPostImageErrorState extends SocialStates{}
class SocialClosePickPostImageState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends   SocialStates{
  final String error;
  SocialGetPostsErrorState(this.error);
}
class SocialGetPostsLoadingState extends SocialStates{}

class SocialErrorLikePostState extends SocialStates{}
class SocialSuccessLikePostState extends SocialStates{}
class SocialGetLikesSuccessState    extends SocialStates{}

class SocialErrorCommentPostState extends SocialStates{}
class SocialSuccessCommentPostState extends SocialStates{}


class SocialCommentPostHappenedState extends SocialStates{}
class SocialCommentPostLoadingState extends SocialStates{}
class SocialGetCommentsSuccessState extends SocialStates{}






class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends   SocialStates{
  final String error;
  SocialGetAllUsersErrorState(this.error);
}
class SocialGetAllUsersLoadingState extends SocialStates{}

//chat details screen
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageLoadingState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{
  final  String error;
  SocialSendMessageErrorState(this.error);
}

class SocialGetAllMessagesSuccessState extends SocialStates{}
class SocialGetAllMessagesLoadingState extends SocialStates{}
class SocialGetAllMessagesErrorState extends SocialStates{
  final  String error;
  SocialGetAllMessagesErrorState(this.error);
}

