import 'package:chat_app/lauout/chat_app/Cubit/cubit.dart';
import 'package:chat_app/lauout/chat_app/Cubit/state.dart';
import 'package:chat_app/models/social_app/social_user_model.dart';
import 'package:chat_app/modules/chat_app/chat_details/chat_details_screen.dart';
import 'package:chat_app/shared/Components/component.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: SocialAppCubit.get(context).users.length > 0 &&
                SocialAppCubit.get(context).model != null,
            builder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    SocialAppCubit.get(context).users[index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: SocialAppCubit.get(context).users.length),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatDetails(
                model: model,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.name}',
                      style: TextStyle(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
        ),
      );
}
