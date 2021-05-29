import 'package:chat_app/lauout/chat_app/Cubit/cubit.dart';
import 'package:chat_app/lauout/chat_app/Cubit/state.dart';
import 'package:chat_app/shared/Components/component.dart';
import 'package:chat_app/shared/Styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Editing scroll view

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: 'Create Post', actions: [
            defaultTextButton(
                function: () {
                  var nowDate = DateTime.now();
                  if (SocialAppCubit.get(context).postImage == null) {
                    SocialAppCubit.get(context).createPost(
                        dateTime: nowDate.toString(),
                        text: textController.text);
                    textController.text = "";
                    SocialAppCubit.get(context).emitPost();
                    Navigator.pop(context);
                  } else {
                    SocialAppCubit.get(context).uploadPostImage(
                        dateTime: nowDate.toString(),
                        text: textController.text);
                    textController.text = "";
                    SocialAppCubit.get(context).emitPost();
                    SocialAppCubit.get(context).removePostImage();
                    Navigator.pop(context);
                  }
                },
                text: 'Post')
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingStates)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingStates)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/photos/keep-smiling-picture-id509286952?k=6&m=509286952&s=612x612&w=0&h=_AhFLmy9aTE-ng8VSx_p92lJ6iRyr7u0OAwv30DzkAQ='),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        SocialAppCubit.get(context).model.name,
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    maxLines: 5,
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'whats your on mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                if (SocialAppCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                                SocialAppCubit.get(context).postImage),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialAppCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          child: Icon(
                            Icons.close_sharp,
                            size: 20.0,
                          ),
                          radius: 20.0,
                        ),
                      )
                    ],
                  ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            SocialAppCubit.get(context).getImagePost();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text('Add Photo')
                            ],
                          )),
                    ),
                    Expanded(
                      child:
                          TextButton(onPressed: () {}, child: Text('# Tags')),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
