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

  Future<Response?> getMovieList(int page) async {
    try {
      print('URL is $movieBaseUrl$movies');
      final Response response = await _dio
          .get('$movieBaseUrl$movies', queryParameters: {'page': page});
      return response;
    } catch (e) {
      print('Error $e');
      return null;
    }
  }
}
