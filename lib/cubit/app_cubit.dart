import 'package:bloc_getit_practice/models/post_model.dart';
import 'package:bloc_getit_practice/repository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this.apiRepository)
      : super(
          const AppState(
              counter: 0,
              isLoading: false,
              text: '',
              hasError: false,
              postList: []),
        );

  Future<void> increaseNumber(bool isIncreasing) async {
    emit(
      state.copyWith(isLoading: true),
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (isIncreasing) {
      final int number = state.counter + 1;
      emit(
        state.copyWith(counter: number, isLoading: false),
      );
    } else {
      final int number = state.counter - 1;
      emit(
        state.copyWith(counter: number, isLoading: false),
      );
    }
  }

  void changeText() {
    emit(
      state.copyWith(text: "Hello, How is it going?!"),
    );
  }

  final ApiRepository apiRepository;
  Future<void> fetchPostApi() async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final List<Posts> postList = await apiRepository.getPostList();
      emit(
        state.copyWith(postList: postList, isLoading: false),
      );
    } catch (e) {
      print('Error is $e');
    }
  }
}
