import 'package:bloc_getit_practice/models/movie_model.dart';
import 'package:bloc_getit_practice/utils/app_constants.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/movie_rm.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: AppConstants.movieBaseUrl)
abstract class MovieClient {
  factory MovieClient(Dio dio, {String baseUrl}) = _MovieClient;

  @GET(AppConstants.movies)
  Future<MovieModel> getMovieList(
      @Query('page') int page, @Query('q') String searchValue);

  @POST(AppConstants.movies)
  Future<MovieRM> postNewMovie(@Body() FormData body);

  @GET('${AppConstants.movies}/{id}')
  Future<MovieRM> getMovieDetail(@Path("id") id);
  // @MultiPart()
  // Future<double> uploadDocument(
  //     @Part(name: "id") int id, @Part(name: "document") File document);
}
