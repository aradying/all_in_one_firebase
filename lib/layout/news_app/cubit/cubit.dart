import 'package:all_in_one/layout/news_app/cubit/states.dart';
import 'package:all_in_one/modules/news_app/business/business_screen.dart';
import 'package:all_in_one/modules/news_app/science/science_screen.dart';
import 'package:all_in_one/modules/news_app/sports/sports_screen.dart';
import 'package:all_in_one/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_soccer,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': '9b6a7468092f4980a2ff64a7b01fbaaf',
    }).then((value) {
      // // print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      // print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': '9b6a7468092f4980a2ff64a7b01fbaaf',
      }).then((value) {
        // // print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        // print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        // print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apikey': '9b6a7468092f4980a2ff64a7b01fbaaf',
      }).then((value) {
        // // print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        // print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        // print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(NewsGetScienceLoadingState());

    DioHelper.getData(url: 'v2/everything', query: {
      'q': value,
      'apikey': '9b6a7468092f4980a2ff64a7b01fbaaf',
    }).then((value) {
      // // print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      // print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
