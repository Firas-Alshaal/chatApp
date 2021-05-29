import 'package:chat_app/lauout/chat_app/Cubit/cubit.dart';
import 'package:chat_app/lauout/chat_app/social_layout.dart';
import 'package:chat_app/modules/chat_app/social_login_screen/social_login.dart';
import 'package:chat_app/shared/Components/component.dart';
import 'package:chat_app/shared/Styles/themes.dart';
import 'package:chat_app/shared/bloc_observer.dart';
import 'package:chat_app/shared/cubit/cubit.dart';
import 'package:chat_app/shared/cubit/status.dart';
import 'package:chat_app/shared/network/local/cache_helper.dart';
import 'package:chat_app/shared/network/remote/dio_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage massage) async {
  print(massage.data.toString());
  showToast(text: 'BackGround', state: ToastState.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'onMessage', state: ToastState.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'onMessageOpenedApp', state: ToastState.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  bool isDark = CacheHelper.getData(key: 'isDark');
  uId = CacheHelper.getData(key: 'uId');

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLogin();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeModeApp(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialAppCubit()
            ..getUserData()
            ..getPosts()
            ..getAllUsers(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              //darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: startWidget //startWidget,
              );
        },
      ),
    );
  }
}
