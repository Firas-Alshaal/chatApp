import 'package:chat_app/lauout/chat_app/Cubit/cubit.dart';
import 'package:chat_app/lauout/chat_app/Cubit/state.dart';
import 'package:chat_app/shared/Components/component.dart';
import 'package:chat_app/shared/Styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var socialModel = SocialAppCubit.get(context).model;
        var cubit = SocialAppCubit.get(context);
        var profileCubit = SocialAppCubit.get(context).profileImage;
        var coverCubit = SocialAppCubit.get(context).coverImage;

        nameController.text = socialModel.name;
        phoneController.text = socialModel.phone;
        bioController.text = socialModel.bio;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                  function: () {
                    SocialAppCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text: 'Update'),
              SizedBox(width: 15.0),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUploadUserLoadingStates)
                    LinearProgressIndicator(),
                  if (state is SocialUploadUserLoadingStates)
                    SizedBox(
                      height: 10.0,
                    ),
                  Container(
                    height: 200.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4.0),
                                    topLeft: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverCubit == null
                                        ? NetworkImage('${socialModel.cover}')
                                        : FileImage(coverCubit),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.getImageCover();
                                },
                                icon: CircleAvatar(
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 20.0,
                                  ),
                                  radius: 20.0,
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileCubit == null
                                    ? NetworkImage('${socialModel.image}')
                                    : FileImage(profileCubit),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getImageProfile();
                              },
                              icon: CircleAvatar(
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 20.0,
                                ),
                                radius: 20.0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      cubit.uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    text: 'Upload Image'),
                                if (state is SocialUploadUserLoadingStates)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUploadUserLoadingStates)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        SizedBox(
                          width: 8.0,
                        ),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    function: () {
                                      cubit.uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    text: 'Upload Cover'),
                                if (state is SocialUploadUserLoadingStates)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if (state is SocialUploadUserLoadingStates)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        } else
                          return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'phone must not be empty';
                        } else
                          return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call),
                  SizedBox(
                    height: 15.0,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'bio must not be empty';
                        } else
                          return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
