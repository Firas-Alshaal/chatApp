import 'package:chat_app/lauout/chat_app/Cubit/cubit.dart';
import 'package:chat_app/lauout/chat_app/Cubit/state.dart';
import 'package:chat_app/models/social_app/message_model.dart';
import 'package:chat_app/models/social_app/social_user_model.dart';
import 'package:chat_app/shared/Styles/Colors.dart';
import 'package:chat_app/shared/Styles/icon_broken.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetails extends StatelessWidget {
  SocialUserModel model;
  var messageController = TextEditingController();

  ChatDetails({this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialAppCubit.get(context).getMessages(receiveId: model.uId);
        return BlocConsumer<SocialAppCubit, SocialAppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(model.image),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(model.name),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialAppCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialAppCubit.get(context).messages[index];
                              if (SocialAppCubit.get(context).model.uId ==
                                  message.senderId) {
                                return buildMyMessage(message);
                              } else {
                                return buildMessage(message);
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15.0,
                                ),
                            itemCount:
                                SocialAppCubit.get(context).messages.length),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey[300], width: 1.0),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type your message here...'),
                                ),
                              ),
                            ),
                            Container(
                              height: 45.0,
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: () {
                                  SocialAppCubit.get(context).sendMessage(
                                    receiveId: model.uId,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                  messageController.text = "";
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback: (context) => equalFalse(context),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              )),
          child: Text('${model.text}'),
        ),
      );

  Widget buildMyMessage(MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          decoration: BoxDecoration(
              color: defaultColor,
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              )),
          child: Text('${model.text}'),
        ),
      );

  Widget equalFalse(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SizedBox(height: 75),
          Text('Write Any think to ${model.name}'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300], width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here...'),
                          ),
                        ),
                      ),
                      Container(
                        height: 45.0,
                        color: defaultColor,
                        child: MaterialButton(
                          onPressed: () {
                            SocialAppCubit.get(context).sendMessage(
                              receiveId: model.uId,
                              dateTime: DateTime.now().toString(),
                              text: messageController.text,
                            );
                            messageController.text = "";
                          },
                          minWidth: 1.0,
                          child: Icon(
                            IconBroken.Send,
                            size: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
