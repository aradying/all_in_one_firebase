import 'package:all_in_one/models/shop_app_model/search_model.dart';
import 'package:all_in_one/modules/shop_app/search/cubit/states.dart';
import 'package:all_in_one/shared/components/constants.dart';
import 'package:all_in_one/shared/network/end_points.dart';
import 'package:all_in_one/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  Future<void> Search(String text) async {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      // print(error.toString());
      emit(SearchErrorState());
    });
  }
}
