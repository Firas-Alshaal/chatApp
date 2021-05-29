import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_app/lauout/chat_app/Cubit/state.dart';
import 'package:chat_app/models/social_app/message_model.dart';
import 'package:chat_app/models/social_app/post_model.dart';
import 'package:chat_app/models/social_app/social_user_model.dart';
import 'package:chat_app/modules/chat_app/chats/chat.dart';
import 'package:chat_app/modules/chat_app/feeds/feeds.dart';
import 'package:chat_app/modules/chat_app/settings/setting.dart';
import 'package:chat_app/modules/chat_app/users/users_screen.dart';
import 'package:chat_app/shared/Components/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(SocialInitializeStates());

  static SocialAppCubit get(context) => BlocProvider.of(context);

  SocialUserModel model;

  void getUserData() {
    emit(SocialGetUserLoadingStates());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      model = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessStates());
    }).catchError((error) {
      SocialGetUserErrorStates(error.toString());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    //NewPostScreen(),
    UsersScreen(),
    SettingScreen(),
  ];

  List<String> title = [
    "Feeds",
    "Chats",
    //"Post",
    "Users",
    "Settings",
  ];

  void changeNavigationBar(int index) {
    if (index == 1) {
      getAllUsers();
      currentIndex = index;
      emit(SocialBottomNavigationBarStates());
    } else {
      currentIndex = index;
      emit(SocialBottomNavigationBarStates());
    }
    /*if (index == 2) {
      emit(SocialNewPostStates());
    } else {
      currentIndex = index;
      emit(SocialBottomNavigationBarStates());
    }*/
  }

  File profileImage;
  var picker = ImagePicker();

  Future<void> getImageProfile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImageSuccessStates());
    } else {
      print('No image selected.');
      emit(SocialProfileImageErrorStates());
    }
  }

  File coverImage;

  Future<void> getImageCover() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImageSuccessStates());
    } else {
      print('No cover selected.');
      emit(SocialCoverImageErrorStates());
    }
  }

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,
    String image,
    String cover,
  }) {
    emit(SocialUploadUserLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorStates());
    });
  }

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
    String image,
    String cover,
  }) {
    emit(SocialUploadUserLoadingStates());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorStates());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorStates());
    });
  }

/*
  void updateUserImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    */
/*if (coverImage != null) {
      uploadCoverImage();
    } else if (profileImage != null) {
      uploadProfileImage();
    } else {}*/ /*

    if (coverImage != null || profileImage != null) {
      uploadCoverImage();
      uploadProfileImage();
    } else {
      updateUserData(name: name, phone: phone, bio: bio);
    }
  }
*/

  void updateUserData({
    @required String name,
    @required String phone,
    @required String bio,
    String image,
    String cover,
  }) {
    emit(SocialUploadUserLoadingStates());
    SocialUserModel modelUpdate = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: model.email,
      image: image ?? model.image,
      cover: cover ?? model.cover,
      uId: model.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(modelUpdate.toJson())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUploadUserErrorStates());
    });
  }

  // Add post
  File postImage;

  Future<void> getImagePost() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImageSuccessStates());
    } else {
      print('No cover selected.');
      emit(SocialPostImageErrorStates());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageStates());
  }

  void uploadPostImage({
    @required String dateTime,
    String image,
    @required String text,
  }) {
    emit(SocialCreatePostLoadingStates());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage.path).pathSegments.last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          imagePost: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorStates());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  void createPost({
    @required String dateTime,
    @required String text,
    String imagePost,
  }) {
    emit(SocialCreatePostLoadingStates());
    PostModel modelPost = PostModel(
      name: model.name,
      uId: model.uId,
      image: model.image,
      text: text,
      dateTime: dateTime,
      postImage: imagePost ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(modelPost.toJson())
        .then((value) {
      emit(SocialCreatePostSuccessStates());
    }).catchError((error) {
      emit(SocialCreatePostErrorStates());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void emitPost() {
    emit(SocialNewPostStates());
  }

/*  void getPosts() {
    emitPost();
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostSuccessStates());
    }).catchError((error) {
      emit(SocialGetPostErrorStates(error.toString()));
    });
  }
  */
  // Real Time Post

  void getPosts() {
    emitPost();
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        element.reference.collection('likes').snapshots().listen((event) {
          likes.add(event.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
      });
      emit(SocialGetPostSuccessStates());
    });
  }

  // Likes

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessStates());
    }).catchError((error) {
      SocialLikePostErrorStates(error.toString());
    });
  }

  // Get User to chat

  List<SocialUserModel> users = [];

  void getAllUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model.uId) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        });
        emit(SocialGetAllUserSuccessStates());
      }).catchError((error) {
        emit(SocialGetAllUserErrorStates(error.toString()));
      });
  }

  void sendMessage({
    @required String receiveId,
    @required String dateTime,
    @required String text,
  }) {
    MessageModel msgModel = MessageModel(
      senderId: model.uId,
      receiveId: receiveId,
      dateTime: dateTime,
      text: text,
    );

    // my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiveId)
        .collection('messages')
        .add(msgModel.toJson())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessageErrorStates());
    });

    // other chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiveId)
        .collection('chats')
        .doc(model.uId)
        .collection('messages')
        .add(msgModel.toJson())
        .then((value) {
      emit(SocialSendMessageSuccessStates());
    }).catchError((error) {
      emit(SocialSendMessageErrorStates());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({@required String receiveId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .collection('chats')
        .doc(receiveId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialReceiveMessageSuccessStates());
    });
  }
}
