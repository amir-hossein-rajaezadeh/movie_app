import 'package:bloc_getit_practice/utils/app_constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  Future<Response?> getPostData() async {
    try {
      final Response response = await _dio.get('$baseUrl$posts');
      return response;
    } catch (e) {
      print('Error $e');
      return null;
    }
  }
}
