import 'package:bloc_getit_practice/models/movie_model.dart';
import 'package:equatable/equatable.dart';

import '../models/post_model.dart';

class AppState extends Equatable {
  final bool hasError;
  final List<PostModel> postList;
  final List<MovieItem> movieList;
  final int page;
  final int counter;
  final bool isLoading;
  final String text;
  final String? selectedCountryName;
  final String? selectedMovieDate;
  final String? selectedImage;
  final int? movieRate;

  const AppState(
      {required this.page,
      required this.hasError,
      required this.postList,
      required this.movieList,
      required this.counter,
      required this.isLoading,
      required this.text,
      this.selectedCountryName,
      this.selectedMovieDate,
      this.selectedImage,
      this.movieRate});

  AppState copyWith(
      {bool? hasError,
      List<PostModel>? postList,
      List<MovieItem>? movieList,
      int? counter,
      int? page,
      bool? isLoading,
      String? text,
      String? selectedCountryName,
      String? selectedMovieTime,
      String? selectedImage,
      int? movieRate}) {
    return AppState(
        movieList: movieList ?? this.movieList,
        postList: postList ?? this.postList,
        hasError: hasError ?? this.hasError,
        page: page ?? this.page,
        counter: counter ?? this.counter,
        isLoading: isLoading ?? this.isLoading,
        text: text ?? this.text,
        selectedCountryName: selectedCountryName ?? this.selectedCountryName,
        selectedMovieDate: selectedMovieTime ?? selectedMovieDate,
        selectedImage: selectedImage ?? this.selectedImage,
        movieRate: movieRate ?? this.movieRate);
  }

  @override
  List<Object?> get props => [
        counter,
        isLoading,
        text,
        postList,
        hasError,
        movieList,
        page,
        selectedCountryName,
        selectedMovieDate,
        selectedImage,
        movieRate
      ];
}
