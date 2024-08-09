import 'package:all_in_one/firebase_options.dart';
import 'package:all_in_one/layout/news_app/cubit/cubit.dart';
import 'package:all_in_one/layout/shop_app/cubit/cubit.dart';
import 'package:all_in_one/layout/social_app/cubit/cubit.dart';
import 'package:all_in_one/layout/social_app/social_layout.dart';
import 'package:all_in_one/modules/social_app/login/social_login_screen.dart';
import 'package:all_in_one/shared/bloc_observer.dart';
import 'package:all_in_one/shared/components/constants.dart';
import 'package:all_in_one/shared/cubit/cubit.dart';
import 'package:all_in_one/shared/cubit/states.dart';
import 'package:all_in_one/shared/network/local/cache_helper.dart';
import 'package:all_in_one/shared/network/remote/dio_helper.dart';
import 'package:all_in_one/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');
  // if (onBoarding != null) {
  //   if (token != null) {
  //     widget =  ShopLayout();
  //   } else {
  //     widget =  ShopLoginScreen();
  //   }
  // } else {
  //   widget =  OnBoardingScreen();
  // }

  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = const SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

  const MyApp({super.key, required this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                // ThemeMode.dark,
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
// abullah@gmail.com 1234567
// aradying@gmail.com 123456
// ahmed@gmail.com 123456
