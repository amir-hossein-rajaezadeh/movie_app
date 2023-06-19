import 'package:bloc_getit_practice/utils/app_constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  Future<Response?> getPostData() async {
    try {
      print('URL is $postBaseUrl$posts');
      final Response response = await _dio.get('$postBaseUrl$posts');

      return response;
    } catch (e) {
      print('Error $e');
      return null;
    }
  }

  Future<Response?> getMovieList(int page, String searchValue) async {
    try {
      print('URL is $movieBaseUrl$movies');
      print('q is $searchValue, page is $page');

      final Response response = await _dio.get('$movieBaseUrl$movies',
          queryParameters: {'q': searchValue, 'page': page});
      print('response is ${response.data}');

      return response;
    } catch (e) {
      print('Error $e');
      return null;
    }
  }

  Future<Response?> addMovie(FormData data) async {
    try {
      final Response response =
          await _dio.post('$movieBaseUrl$movies/multi', data: data);
      print('response is ${response.data}');

      return response;
    } catch (e) {
      print('Error $e');
      return null;
    }
  }
}
