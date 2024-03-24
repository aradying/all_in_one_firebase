import 'package:all_in_one/layout/shop_app/cubit/states.dart';
import 'package:all_in_one/models/shop_app_model/categories_model.dart';
import 'package:all_in_one/models/shop_app_model/change_favorites_model.dart';
import 'package:all_in_one/models/shop_app_model/favorites_model.dart';
import 'package:all_in_one/models/shop_app_model/home_model.dart';
import 'package:all_in_one/models/shop_app_model/login_model.dart';
import 'package:all_in_one/modules/shop_app/categories/categories_screen.dart';
import 'package:all_in_one/modules/shop_app/favorites/favorites_screen.dart';
import 'package:all_in_one/modules/shop_app/products/products_screen.dart';
import 'package:all_in_one/modules/shop_app/settings/settings_screen.dart';
import 'package:all_in_one/shared/components/constants.dart';
import 'package:all_in_one/shared/network/end_points.dart';
import 'package:all_in_one/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int?, bool?> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // printFullText(homeModel!.data!.banners[0].image!);
      // // print(homeModel!.status);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      }
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      // print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      // print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      // print(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      // print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      //printFullText(userModel! .data!.name!);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      // print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      //printFullText(userModel! .data!.name!);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      // print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}

//   ShopRegisterModel? userModel;
//   void getUserData(){
//     emit(ShopLoadingUserDataState());
//     DioHelper.getData(
//       url: PROFILE,
//       token:token,
//     ).then((value) {
//       userModel=ShopRegisterModel.fromJason(value?.data);
//       //printFullText(userModel! .data!.name!);
//
//       emit(ShopSuccessUserDataState(userModel!));
//     }).catchError((error){
// //       print(error.toString());
//       emit(ShopErrorGUserDataState());
//     });
//   }
//   void updateUserData({
//     required String name,
//     required String email,
//     required String phone,
//   }){
//     emit(ShopLoadingUpdateUserState());
//     DioHelper.putData(
//       url: UPDATE_PROFILE,
//       token:token,
//       data: {
//         'name':name,
//         'email':email,
//         'phone':phone,
//       },
//     ).then((value) {
//       userModel=ShopRegisterModel.fromJason(value.data);
//       //printFullText(userModel! .data!.name!);
//
//       emit(ShopSuccessUpdateUserState(userModel!));
//     }).catchError((error){
// //       print(error.toString());
//       emit(ShopErrorUpdateUserState());
//     });
//   }
// }
