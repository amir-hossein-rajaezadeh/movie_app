import 'package:equatable/equatable.dart';

import '../models/post_model.dart';

class AppState extends Equatable {
  final bool hasError;
  final List<Posts> postList;
  final int counter;
  final bool isLoading;
  final String text;
  const AppState(
      {required this.hasError,
      required this.postList,
      required this.counter,
      required this.isLoading,
      required this.text});

  AppState copyWith(
      {bool? hasError,
      List<Posts>? postList,
      int? counter,
      bool? isLoading,
      String? text}) {
    return AppState(
        postList: postList ?? this.postList,
        hasError: hasError ?? this.hasError,
        counter: counter ?? this.counter,
        isLoading: isLoading ?? this.isLoading,
        text: text ?? this.text);
  }

  @override
  List<Object?> get props => [counter, isLoading, text, postList, hasError];
}
