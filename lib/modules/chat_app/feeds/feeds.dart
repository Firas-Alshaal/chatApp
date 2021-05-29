import 'package:chat_app/lauout/chat_app/Cubit/cubit.dart';
import 'package:chat_app/lauout/chat_app/Cubit/state.dart';
import 'package:chat_app/models/social_app/post_model.dart';
import 'package:chat_app/shared/Styles/Colors.dart';
import 'package:chat_app/shared/Styles/icon_broken.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialAppCubit.get(context).posts.length > 0 &&
              SocialAppCubit.get(context).model != null,
          builder: (context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image(
                          width: double.infinity,
                          image: NetworkImage(
                              'https://i.pinimg.com/736x/d3/b6/01/d3b60144efd9b1f288202bbae39d84c3.jpg'),
                          fit: BoxFit.cover,
                          height: 200.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate With Friends',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildPostItem(
                        SocialAppCubit.get(context).posts[index],
                        context,
                        index),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.0,
                    ),
                    itemCount: SocialAppCubit.get(context).posts.length,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          },
          fallback: (context) {
            return Center(
              child: CircularProgressIndicator()
            );
          },
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        Row(
                          children: [
                            Text(
                              "${model.name}",
                              style: TextStyle(
                                height: 1.4,
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16.0,
                            ),
                          ],
                        ),
                        Text(
                          "${model.dateTime}",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  IconButton(
                      icon: Icon(
                        IconBroken.More_Circle,
                        color: defaultColor,
                        size: 20.0,
                      ),
                      onPressed: () {}),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialAppCubit.get(context).likes[index]} Likes',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '0 comments',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                '${SocialAppCubit.get(context).model.image}'),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text("write a comment...",
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {
                      SocialAppCubit.get(context)
                          .likePost(SocialAppCubit.get(context).postId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
