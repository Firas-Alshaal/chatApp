import 'package:chat_app/lauout/chat_app/Cubit/cubit.dart';
import 'package:chat_app/lauout/chat_app/Cubit/state.dart';
import 'package:chat_app/models/social_app/post_model.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.get(context).posts.length > 0,
          builder: (context) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5, mainAxisSpacing: 10, crossAxisCount: 2),
              itemCount: SocialAppCubit.get(context).posts.length,
              itemBuilder: (context, index) {
                return setImage(
                    SocialAppCubit.get(context).posts[index], context, index);
              },
            );
          },
          fallback: (context) => Center(child: Text('Image Not Found')),
        );
      },
    );
  }

  Widget setImage(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 10.0),
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${model.postImage}'),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
}

/*Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [if (model.postImage != '')
      Padding(
        padding: const EdgeInsetsDirectional.only(top: 10.0),
        child: Container(
          height: 140.0,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('${model.postImage}'),
            ),
          ),
        ),
      )])));*/
