import 'dart:io';

import 'package:bloc_getit_practice/models/movie_model.dart';
import 'package:bloc_getit_practice/models/post_model.dart';
import 'package:bloc_getit_practice/repository/api_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  List<MovieItem> movieList = [];

  AppCubit(this.apiRepository)
      : super(
          const AppState(
            counter: 0,
            isLoading: false,
            text: '',
            hasError: false,
            postList: [],
            movieList: [],
            page: 0,
          ),
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
      final List<PostModel> postList = await apiRepository.getPostList();
      emit(
        state.copyWith(postList: postList, isLoading: false),
      );
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> fetchMovieApi() async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final movieListServer = await apiRepository.getMovieList(0, '');
      movieList = movieListServer.movie ?? [];
      emit(
        state.copyWith(
            movieList: movieListServer.movie, isLoading: false, page: 0),
      );
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> updatePage(String searchValue) async {
    emit(state.copyWith(page: state.page + 1, isLoading: true));

    try {
      /* Need to add Movie model in State */
      final movieListServer =
          await apiRepository.getMovieList(state.page, searchValue);

      if (movieListServer.metadata!.pageCount! >
          int.parse(movieListServer.metadata?.currentPage ?? '0')) {
        movieList.addAll(movieListServer.movie?.toList() ?? []);

        emit(
          state.copyWith(movieList: movieList, isLoading: false),
        );
      } else {
        emit(
          state.copyWith(isLoading: false),
        );
      }
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> searchMovie(String searchValue) async {
    emit(state.copyWith(isLoading: true));

    try {
      final movieListServer = await apiRepository.getMovieList(0, searchValue);

      emit(
        state.copyWith(movieList: movieListServer.movie, isLoading: false),
      );
    } catch (e) {
      print('Error is $e');
    }
  }

  void onSearch(TextEditingController searchTextFieldController) {
    searchTextFieldController.addListener(() async {
      String searchValue = searchTextFieldController.value.text;

      if (searchValue != searchValue) {
        emit(state.copyWith(isLoading: true));

        final movieListServer = await apiRepository.getMovieList(
            0, searchTextFieldController.value.text);

        emit(state.copyWith(
            page: 0, movieList: movieListServer.movie, isLoading: false));

        print('seatcField value is ${searchTextFieldController.value.text}');
      }
    });
  }

  Future<void> addMovie() async {
    croopImage();
  }

  Future<void> croopImage() async {
    final File? imageFile;
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imageFile = File(image!.path);

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    uploadSelectedImage(croppedFile!.path);
  }

  Future<void> uploadSelectedImage(
    String file,
  ) async {
    FormData formData = FormData.fromMap({
      "title": "FastAndFeriousInUSA5",
      'imdb_id': 'tt0232500',
      'country': 'USA',
      'year': '2001',
      "poster": await MultipartFile.fromFile(
        file,
        filename: file,
      ),
      "type": "image/png"
    });

    // final addedMovie = await apiRepository.addMovie(formData);
  }

  Future<void> showLoadong() async {
    emit(
      state.copyWith(isLoading: true),
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
    emit(
      state.copyWith(isLoading: false),
    );
  }
}
