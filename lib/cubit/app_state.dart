import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final int counter;
  final bool isLoading;
  final String text;
  const AppState(
      {required this.counter, required this.isLoading, required this.text});

  AppState copyWith({int? counter, bool? isLoading, String? text}) {
    return AppState(
        counter: counter ?? this.counter,
        isLoading: isLoading ?? this.isLoading,
        text: text ?? this.text);
  }

  @override
  List<Object?> get props => [counter, isLoading, text];
}
