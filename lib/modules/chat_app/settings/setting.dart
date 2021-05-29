import 'package:chat_app/lauout/chat_app/Cubit/cubit.dart';
import 'package:chat_app/lauout/chat_app/Cubit/state.dart';
import 'package:chat_app/modules/chat_app/edit_profile/edit_profile.dart';
import 'package:chat_app/shared/Components/component.dart';
import 'package:chat_app/shared/Styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var socialModel = SocialAppCubit.get(context).model;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4.0),
                            topLeft: Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage('${socialModel.cover}'),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 65.0,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage('${socialModel.image}'),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "${socialModel.name}",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "${socialModel.bio}",
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "posts",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "328",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Photo",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "10K",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Followers",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "64",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              "Followings",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text("Add Photo"),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfile());
                      },
                      child: Icon(
                        IconBroken.Edit,
                        size: 16.0,
                      ))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
