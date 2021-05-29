import 'package:chat_app/shared/cubit/status.dart';
import 'package:chat_app/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitializeStates());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;


  void changeModeApp({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeStates());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeStates());
      });
    }
  }
}
