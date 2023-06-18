import 'package:bloc_getit_practice/models/movie_model.dart';
import 'package:equatable/equatable.dart';

import '../models/post_model.dart';

class AppState extends Equatable {
  final bool hasError;
  final List<PostModel> postList;
  final MovieModel movieModel;

  final int counter;
  final bool isLoading;
  final String text;
  const AppState(
      {required this.hasError,
      required this.postList,
      required this.movieModel,
      required this.counter,
      required this.isLoading,
      required this.text});

  AppState copyWith(
      {bool? hasError,
      List<PostModel>? postList,
      MovieModel? movieModel,
      int? counter,
      bool? isLoading,
      String? text}) {
    return AppState(
        movieModel: movieModel ?? this.movieModel,
        postList: postList ?? this.postList,
        hasError: hasError ?? this.hasError,
        counter: counter ?? this.counter,
        isLoading: isLoading ?? this.isLoading,
        text: text ?? this.text);
  }

  @override
  List<Object?> get props => [counter, isLoading, text, postList, hasError];
}
