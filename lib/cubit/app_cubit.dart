import 'dart:async';
import 'dart:io';

import 'package:bloc_getit_practice/models/post_model.dart';
import 'package:bloc_getit_practice/repository/api_repository.dart';
import 'package:bloc_getit_practice/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../models/movie_rm.dart';
import '../service/rest_client.dart';
import '../utils/app_constants.dart';
import 'app_state.dart';

final dio = Dio();
final client = MovieClient(dio);
double selectedBannerItemHeight = 100;

class AppCubit extends Cubit<AppState> {
  List<MovieRM> movieList = [];
  List<MovieRM> movieListByGenre = [];

  AppCubit(this.apiRepository)
      : super(
          const AppState(
              counter: 0,
              isLoading: false,
              text: '',
              hasError: false,
              postList: [],
              movieList: [],
              genreList: [],
              page: 0,
              bannerPage: 0,
              actiorTabSelected: true,
              movieDetailBottomSheetHeight: 470,
              movieListByGenre: []),
        );

  onPageViewChange(int page) {
    emit(
      state.copyWith(bannerPage: page),
    );
  }

  double getSelectedBannerHeight() => selectedBannerItemHeight;

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
      final movieListServer = await client.getMovieList(0, '');

      movieList = movieListServer.movie ?? [];
      emit(
        state.copyWith(
            movieList: movieListServer.movie, isLoading: false, page: 0),
      );
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> getGenreList() async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final genreList = await client.getGenresList();

      emit(
        state.copyWith(
          genreList: genreList,
          isLoading: false,
        ),
      );
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> updatePage(
      String searchValue, bool movieByGenre, int genreId) async {
    emit(
      state.copyWith(page: state.page + 1, isLoading: true),
    );

    try {
      /* Need to add Movie model in State */
      if (movieByGenre) {
        final genreMoviesServer =
            await client.getMovieListByGenreId(genreId, state.page);
        movieListByGenre.addAll(genreMoviesServer.movie?.toList() ?? []);
        emit(
          state.copyWith(movieListByGenre: movieListByGenre, isLoading: false),
        );
      } else {
        final movieListServer =
            await client.getMovieList(state.page, searchValue);

        if (movieListServer.metadata!.pageCount! >
            int.parse(movieListServer.metadata?.currentPage ?? '0')) {
          movieList.addAll(movieListServer.movie?.toList() ?? []);

          emit(
            state.copyWith(movieList: movieList, isLoading: false),
          );
        }
      }
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> searchMovie(String searchValue) async {
    emit(state.copyWith(isLoading: true));

    try {
      final movieListServer = await client.getMovieList(1, searchValue);

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
        final movieListServer = await client.getMovieList(
            state.page, searchTextFieldController.value.text);

        emit(state.copyWith(
            page: 0, movieList: movieListServer.movie, isLoading: false));

        print('seatcField value is ${searchTextFieldController.value.text}');
      }
    });
  }

  Future<void> selectImage() async {
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
    emit(
      state.copyWith(selectedImage: croppedFile!.path),
    );
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

  void setSelectedCountryName(int index, List<String> countryList) {
    String selectedCountry = countryList[index];
    emit(
      state.copyWith(selectedCountryName: selectedCountry),
    );
  }

  void setSelectedMovieDate(String date) {
    emit(
      state.copyWith(
        selectedMovieTime: date.splitDate(),
      ),
    );
  }

  void setMovieRate(int rate) {
    emit(
      state.copyWith(movieRate: rate),
    );
  }

  Future<void> addMovie(
      String movieName, String movieDirector, BuildContext context) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    print(
        'title is $movieName  country is ${state.selectedCountryName!.split(' ')[1]},  year is ${state.selectedMovieDate}');
    FormData formData = FormData.fromMap({
      "title": movieName,
      'imdb_id': 'tt0232500',
      'director': movieDirector,
      'country': state.selectedCountryName!.split(' ')[1],
      'imdb_rating': state.movieRate,
      'year': state.selectedMovieDate!.split("-")[0],
      // if (state.selectedImage != '')
      //   "poster": await MultipartFile.fromFile(
      //     state.selectedImage!,
      //     filename: state.selectedImage!,
      //   ),
    });

    Map<String, dynamic> param = {};
    // param = {
    //   "title": movieName,
    //   'imdb_id': 'tt0232500',
    //   'director': movieDirector,
    //   'country': state.selectedCountryName!.split(' ')[1],
    //   'imdb_rating': state.movieRate.toString(),
    //   'year': state.selectedMovieDate!.split("-")[0],
    // };

    try {
      await client.postNewMovie(formData);

      context.pop();
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
  }

  Future<void> getMovieDetailById(int id) async {
    emit(
      state.copyWith(isLoading: true),
    );
    try {
      final movieItemServer = await client.getMovieDetail(id);
      emit(
        state.copyWith(movieItem: movieItemServer, isLoading: false),
      );
    } catch (e) {
      print('Error is $e');
    }
  }

  Future<void> getGenreMovieById(int id) async {
    emit(
      state.copyWith(isLoading: true, movieListByGenre: [], page: 1),
    );
    movieListByGenre.clear();
    try {
      print('dfdf${AppConstants.genres}1/${AppConstants.movies}');

      final genreMoviesServer =
          await client.getMovieListByGenreId(id, state.page);
      movieListByGenre = (genreMoviesServer.movie?.toList() ?? []);
      print('value is ${genreMoviesServer.movie![0].title} ');

      emit(
        state.copyWith(movieListByGenre: movieListByGenre, isLoading: false),
      );
    } catch (e) {
      print('Error is $e');
    }
  }

  Timer? _debounce;

  Timer? getdebounce() => _debounce;

  onSearchTextChanged(String searchValue) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      searchValue.isEmpty ? fetchMovieApi() : searchMovie(searchValue);
    });
  }

  void onTextChange(TextEditingController searchController) {
    useEffect(
      () => () {
        searchController.addListener(
          () {
            onSearchTextChanged(searchController.value.text);
          },
        );
      },
    );
  }

  void onGenreItemClicked(BuildContext context, int genreId, int index) async {}

  void onActorTapClicked() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      emit(
        state.copyWith(
            actiorTabSelected: state.actiorTabSelected ? false : true),
      );
    });
  }

  void changeBottomSheetHeight(double deviceHeight) {
    emit(state.copyWith(
        movieDetailBottomSheetHeight: state.movieDetailBottomSheetHeight == 470
            ? deviceHeight * .85
            : 470));
  }

  int returnYear() {
    String date = state.selectedMovieDate ?? DateTime.now().year.toString();
    int selectedYear = int.parse(date.splitDate().splitDateToYear());
    return selectedYear;
  }

  int returnMonth() {
    String date =
        state.selectedMovieDate ?? DateTime.now().toString().splitDate();
    int selectedMonth = int.parse(date.splitDateToMonth());
    return selectedMonth;
  }

  int returnDay() {
    String date =
        state.selectedMovieDate ?? DateTime.now().toString().splitDate();
    int selectedDay = int.parse(date.splitDateToDay());
    return selectedDay;
  }

  String movieTimeInHoure() {
    String movieTimeInMinute = state.movieItem!.runtime!.split(' ')[0];

    String movieTimeDevidedToHoure =
        movieTimeInMinute.devideMinuteToHour(movieTimeInMinute);

    String finalMovieTimeInHourAndMinute = movieTimeInMinute
        .devideHoureAndMinute(movieTimeDevidedToHoure, movieTimeInMinute);

    return finalMovieTimeInHourAndMinute;
  }
}
