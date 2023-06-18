import 'package:bloc_getit_practice/models/post_model.dart';
import 'package:bloc_getit_practice/service/api_service.dart';

class ApiRepository {
  ApiRepository(this.apiService);
  final ApiService apiService;

  Future<List<Posts>> getPostList() async {
    final response = await apiService.getPostData();

    if (response != null) {
      final data = response.data as List<dynamic>;
      return data.map((singlePost) => Posts.fromJson(singlePost)).toList();
    } else {
      return [];
    }
  }
}
