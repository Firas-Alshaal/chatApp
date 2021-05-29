abstract class SocialAppStates {}

class SocialInitializeStates extends SocialAppStates {}

class SocialGetUserLoadingStates extends SocialAppStates {}

class SocialGetUserSuccessStates extends SocialAppStates {}

class SocialGetUserErrorStates extends SocialAppStates {
  final String error;

  SocialGetUserErrorStates(this.error);
}

class SocialBottomNavigationBarStates extends SocialAppStates {}

class SocialNewPostStates extends SocialAppStates {}

// image picker
class SocialProfileImageSuccessStates extends SocialAppStates {}

class SocialProfileImageErrorStates extends SocialAppStates {}

class SocialCoverImageSuccessStates extends SocialAppStates {}

class SocialCoverImageErrorStates extends SocialAppStates {}

// upload

class SocialUploadProfileImageSuccessStates extends SocialAppStates {}

class SocialUploadProfileImageErrorStates extends SocialAppStates {}

class SocialUploadCoverImageSuccessStates extends SocialAppStates {}

class SocialUploadCoverImageErrorStates extends SocialAppStates {}

class SocialUploadUserLoadingStates extends SocialAppStates {}

class SocialUploadUserErrorStates extends SocialAppStates {}

// Add post
class SocialCreatePostLoadingStates extends SocialAppStates {}

class SocialCreatePostSuccessStates extends SocialAppStates {}

class SocialCreatePostErrorStates extends SocialAppStates {}

class SocialPostImageSuccessStates extends SocialAppStates {}

class SocialPostImageErrorStates extends SocialAppStates {}

class SocialRemovePostImageStates extends SocialAppStates {}

// Get data Post

class SocialGetPostLoadingStates extends SocialAppStates {}

class SocialGetPostSuccessStates extends SocialAppStates {}

class SocialGetPostErrorStates extends SocialAppStates {
  final String error;

  SocialGetPostErrorStates(this.error);
}

// Like

class SocialLikePostSuccessStates extends SocialAppStates {}

class SocialLikePostErrorStates extends SocialAppStates {
  final String error;

  SocialLikePostErrorStates(this.error);
}

// Get User to chat

class SocialGetAllUserSuccessStates extends SocialAppStates {}

class SocialGetAllUserErrorStates extends SocialAppStates {
  final String error;

  SocialGetAllUserErrorStates(this.error);
}

// Sender and Receive Message

class SocialSendMessageSuccessStates extends SocialAppStates {}

class SocialSendMessageErrorStates extends SocialAppStates {}

class SocialReceiveMessageSuccessStates extends SocialAppStates {}

