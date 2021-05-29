import 'package:chat_app/lauout/chat_app/Cubit/cubit.dart';
import 'package:chat_app/lauout/chat_app/Cubit/state.dart';
import 'package:chat_app/modules/chat_app/newPost/newPost.dart';
import 'package:chat_app/shared/Components/component.dart';
import 'package:chat_app/shared/Styles/Colors.dart';
import 'package:chat_app/shared/Styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialAppCubit, SocialAppStates>(
      listener: (context, state) {
        /*if (state is SocialNewPostStates) {
          navigateTo(context, NewPostScreen());
        }*/
      },
      builder: (context, state) {
        var cubit = SocialAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          /* bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chat'),
              */ /* BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),*/ /*
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (int index) {
              cubit.changeNavigationBar(index);
            },
          ),*/
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            // color: Colors.red,
            notchMargin: 10.0,
            child: Container(
              height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            SocialAppCubit.get(context).currentIndex = 0;
                            SocialAppCubit.get(context).changeNavigationBar(
                                SocialAppCubit.get(context).currentIndex);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Home,
                                color:
                                    SocialAppCubit.get(context).currentIndex ==
                                            0
                                        ? defaultColor
                                        : Colors.black,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: SocialAppCubit.get(context)
                                              .currentIndex ==
                                          0
                                      ? defaultColor
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            SocialAppCubit.get(context).currentIndex = 1;
                            SocialAppCubit.get(context).changeNavigationBar(
                                SocialAppCubit.get(context).currentIndex);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                color:
                                    SocialAppCubit.get(context).currentIndex ==
                                            1
                                        ? defaultColor
                                        : Colors.black,
                              ),
                              Text(
                                'Chat',
                                style: TextStyle(
                                  color: SocialAppCubit.get(context)
                                              .currentIndex ==
                                          1
                                      ? defaultColor
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            SocialAppCubit.get(context).currentIndex = 2;
                            SocialAppCubit.get(context).changeNavigationBar(
                                SocialAppCubit.get(context).currentIndex);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Image_2,
                                color:
                                    SocialAppCubit.get(context).currentIndex ==
                                            2
                                        ? defaultColor
                                        : Colors.black,
                              ),
                              Text(
                                'Images',
                                style: TextStyle(
                                  color: SocialAppCubit.get(context)
                                              .currentIndex ==
                                          2
                                      ? defaultColor
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 0.1,
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            SocialAppCubit.get(context).currentIndex = 3;
                            SocialAppCubit.get(context).changeNavigationBar(
                                SocialAppCubit.get(context).currentIndex);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconBroken.Setting,
                                color:
                                    SocialAppCubit.get(context).currentIndex ==
                                            3
                                        ? defaultColor
                                        : Colors.black,
                              ),
                              Text(
                                'Settings',
                                style: TextStyle(
                                  color: SocialAppCubit.get(context)
                                              .currentIndex ==
                                          3
                                      ? defaultColor
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, NewPostScreen());
            },
            //foregroundColor: Colors.deepOrange,
            backgroundColor: Colors.deepOrange,
            child: Icon(
              IconBroken.Paper_Upload,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
