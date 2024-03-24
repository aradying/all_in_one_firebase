import 'package:all_in_one/layout/news_app/cubit/cubit.dart';
import 'package:all_in_one/layout/shop_app/cubit/cubit.dart';
import 'package:all_in_one/layout/shop_app/shop_layout.dart';
import 'package:all_in_one/modules/shop_app/login/shop_login_screen.dart';
import 'package:all_in_one/modules/shop_app/on_boarding/onboarding_screen.dart';
import 'package:all_in_one/shared/bloc_observer.dart';
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
  // await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.getData(key: 'token');
  // print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
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
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
// abullah@gmail.com 1234567
