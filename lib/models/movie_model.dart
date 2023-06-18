class MovieModel {
  MovieModel({
    required this.movie,
    required this.metadata,
  });
  late final List<MovieItem> movie;
  late final Metadata metadata;

  MovieModel.fromJson(Map<String, dynamic> json) {
    movie = List.from(json['data']).map((e) => MovieItem.fromJson(e)).toList();
    metadata = Metadata.fromJson(json['metadata']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = movie.map((e) => e.toJson()).toList();
    data['metadata'] = metadata.toJson();
    return data;
  }
}

class MovieItem {
  MovieItem({
    required this.id,
    required this.title,
    required this.poster,
    required this.year,
    required this.country,
    required this.imdbRating,
    required this.genres,
    required this.images,
  });
  late final int id;
  late final String title;
  late final String poster;
  late final String year;
  late final String country;
  late final String imdbRating;
  late final List<String> genres;
  late final List<String> images;

  MovieItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    poster = json['poster'];
    year = json['year'];
    country = json['country'];
    imdbRating = json['imdb_rating'];
    genres = List.castFrom<dynamic, String>(json['genres']);
    images = List.castFrom<dynamic, String>(json['images']);
  }

  Map<String, dynamic> toJson() {
    final movie = <String, dynamic>{};
    movie['id'] = id;
    movie['title'] = title;
    movie['poster'] = poster;
    movie['year'] = year;
    movie['country'] = country;
    movie['imdb_rating'] = imdbRating;
    movie['genres'] = genres;
    movie['images'] = images;
    return movie;
  }
}

class Metadata {
  Metadata({
    required this.currentPage,
    required this.perPage,
    required this.pageCount,
    required this.totalCount,
  });
  late final String currentPage;
  late final int perPage;
  late final int pageCount;
  late final int totalCount;

  Metadata.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    pageCount = json['page_count'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final metaData = <String, dynamic>{};
    metaData['current_page'] = currentPage;
    metaData['per_page'] = perPage;
    metaData['page_count'] = pageCount;
    metaData['total_count'] = totalCount;
    return metaData;
  }
}
