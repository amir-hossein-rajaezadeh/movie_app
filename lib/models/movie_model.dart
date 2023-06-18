/// data : [{"id":1,"title":"The Shawshank Redemption","poster":"http://moviesapi.ir/images/tt0111161_poster.jpg","year":"1994","country":"USA","imdb_rating":"9.3","genres":["Crime","Drama"],"images":["http://moviesapi.ir/images/tt0111161_screenshot1.jpg","http://moviesapi.ir/images/tt0111161_screenshot2.jpg","http://moviesapi.ir/images/tt0111161_screenshot3.jpg"]},{"id":2,"title":"The Godfather","poster":"http://moviesapi.ir/images/tt0068646_poster.jpg","year":"1972","country":"USA","imdb_rating":"9.2","genres":["Crime","Drama"],"images":["http://moviesapi.ir/images/tt0068646_screenshot1.jpg","http://moviesapi.ir/images/tt0068646_screenshot2.jpg","http://moviesapi.ir/images/tt0068646_screenshot3.jpg"]},{"id":3,"title":"The Godfather: Part II","poster":"http://moviesapi.ir/images/tt0071562_poster.jpg","year":"1974","country":"USA","imdb_rating":"9.0","genres":["Crime","Drama"],"images":["http://moviesapi.ir/images/tt0071562_screenshot1.jpg","http://moviesapi.ir/images/tt0071562_screenshot2.jpg","http://moviesapi.ir/images/tt0071562_screenshot3.jpg"]},{"id":4,"title":"The Dark Knight","poster":"http://moviesapi.ir/images/tt0468569_poster.jpg","year":"2008","country":"USA, UK","imdb_rating":"9.0","genres":["Action","Crime","Drama"],"images":["http://moviesapi.ir/images/tt0468569_screenshot1.jpg","http://moviesapi.ir/images/tt0468569_screenshot2.jpg","http://moviesapi.ir/images/tt0468569_screenshot3.jpg"]},{"id":5,"title":"12 Angry Men","poster":"http://moviesapi.ir/images/tt0050083_poster.jpg","year":"1957","country":"USA","imdb_rating":"8.9","genres":["Crime","Drama"],"images":["http://moviesapi.ir/images/tt0050083_screenshot1.jpg","http://moviesapi.ir/images/tt0050083_screenshot2.jpg","http://moviesapi.ir/images/tt0050083_screenshot3.jpg"]},{"id":6,"title":"Schindler's List","poster":"http://moviesapi.ir/images/tt0108052_poster.jpg","year":"1993","country":"USA","imdb_rating":"8.9","genres":["Biography","Drama","History"],"images":["http://moviesapi.ir/images/tt0108052_screenshot1.jpg","http://moviesapi.ir/images/tt0108052_screenshot2.jpg","http://moviesapi.ir/images/tt0108052_screenshot3.jpg"]},{"id":7,"title":"Pulp Fiction","poster":"http://moviesapi.ir/images/tt0110912_poster.jpg","year":"1994","country":"USA","imdb_rating":"8.9","genres":["Crime","Drama"],"images":["http://moviesapi.ir/images/tt0110912_screenshot1.jpg","http://moviesapi.ir/images/tt0110912_screenshot2.jpg","http://moviesapi.ir/images/tt0110912_screenshot3.jpg"]},{"id":8,"title":"The Lord of the Rings: The Return of the King","poster":"http://moviesapi.ir/images/tt0167260_poster.jpg","year":"2003","country":"USA, New Zealand","imdb_rating":"8.9","genres":["Adventure","Drama","Fantasy"],"images":["http://moviesapi.ir/images/tt0167260_screenshot1.jpg","http://moviesapi.ir/images/tt0167260_screenshot2.jpg","http://moviesapi.ir/images/tt0167260_screenshot3.jpg"]},{"id":9,"title":"The Good, the Bad and the Ugly","poster":"http://moviesapi.ir/images/tt0060196_poster.jpg","year":"1966","country":"Italy, Spain, West Germany, USA","imdb_rating":"8.9","genres":["Western"],"images":["http://moviesapi.ir/images/tt0060196_screenshot1.jpg","http://moviesapi.ir/images/tt0060196_screenshot2.jpg","http://moviesapi.ir/images/tt0060196_screenshot3.jpg"]},{"id":10,"title":"Fight Club","poster":"http://moviesapi.ir/images/tt0137523_poster.jpg","year":"1999","country":"USA, Germany","imdb_rating":"8.8","genres":["Drama"],"images":["http://moviesapi.ir/images/tt0137523_screenshot1.jpg","http://moviesapi.ir/images/tt0137523_screenshot2.jpg","http://moviesapi.ir/images/tt0137523_screenshot3.jpg"]}]
/// metadata : {"current_page":"1","per_page":10,"page_count":25,"total_count":250}

class MovieModel {
  MovieModel({
    List<MovieItem>? movie,
    Metadata? metadata,
  }) {
    _movieItem = movie;
    _metadata = metadata;
  }

  MovieModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _movieItem = [];
      json['data'].forEach((v) {
        _movieItem?.add(MovieItem.fromJson(v));
      });
    }
    _metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }
  List<MovieItem>? _movieItem;
  Metadata? _metadata;
  MovieModel copyWith({
    List<MovieItem>? data,
    Metadata? metadata,
  }) =>
      MovieModel(
        movie: data ?? _movieItem,
        metadata: metadata ?? _metadata,
      );
  List<MovieItem>? get movie => _movieItem;
  Metadata? get metadata => _metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_movieItem != null) {
      map['data'] = _movieItem?.map((v) => v.toJson()).toList();
    }
    if (_metadata != null) {
      map['metadata'] = _metadata?.toJson();
    }
    return map;
  }
}

/// current_page : "1"
/// per_page : 10
/// page_count : 25
/// total_count : 250

class Metadata {
  Metadata({
    String? currentPage,
    num? perPage,
    num? pageCount,
    num? totalCount,
  }) {
    _currentPage = currentPage;
    _perPage = perPage;
    _pageCount = pageCount;
    _totalCount = totalCount;
  }

  Metadata.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    _perPage = json['per_page'];
    _pageCount = json['page_count'];
    _totalCount = json['total_count'];
  }
  String? _currentPage;
  num? _perPage;
  num? _pageCount;
  num? _totalCount;
  Metadata copyWith({
    String? currentPage,
    num? perPage,
    num? pageCount,
    num? totalCount,
  }) =>
      Metadata(
        currentPage: currentPage ?? _currentPage,
        perPage: perPage ?? _perPage,
        pageCount: pageCount ?? _pageCount,
        totalCount: totalCount ?? _totalCount,
      );
  String? get currentPage => _currentPage;
  num? get perPage => _perPage;
  num? get pageCount => _pageCount;
  num? get totalCount => _totalCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    map['per_page'] = _perPage;
    map['page_count'] = _pageCount;
    map['total_count'] = _totalCount;
    return map;
  }
}

/// id : 1
/// title : "The Shawshank Redemption"
/// poster : "http://moviesapi.ir/images/tt0111161_poster.jpg"
/// year : "1994"
/// country : "USA"
/// imdb_rating : "9.3"
/// genres : ["Crime","Drama"]
/// images : ["http://moviesapi.ir/images/tt0111161_screenshot1.jpg","http://moviesapi.ir/images/tt0111161_screenshot2.jpg","http://moviesapi.ir/images/tt0111161_screenshot3.jpg"]

class MovieItem {
  MovieItem({
    num? id,
    String? title,
    String? poster,
    String? year,
    String? country,
    String? imdbRating,
    List<String>? genres,
    List<String>? images,
  }) {
    _id = id;
    _title = title;
    _poster = poster;
    _year = year;
    _country = country;
    _imdbRating = imdbRating;
    _genres = genres;
    _images = images;
  }

  MovieItem.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _poster = json['poster'];
    _year = json['year'];
    _country = json['country'];
    _imdbRating = json['imdb_rating'];
    _genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  num? _id;
  String? _title;
  String? _poster;
  String? _year;
  String? _country;
  String? _imdbRating;
  List<String>? _genres;
  List<String>? _images;
  MovieItem copyWith({
    num? id,
    String? title,
    String? poster,
    String? year,
    String? country,
    String? imdbRating,
    List<String>? genres,
    List<String>? images,
  }) =>
      MovieItem(
        id: id ?? _id,
        title: title ?? _title,
        poster: poster ?? _poster,
        year: year ?? _year,
        country: country ?? _country,
        imdbRating: imdbRating ?? _imdbRating,
        genres: genres ?? _genres,
        images: images ?? _images,
      );
  num? get id => _id;
  String? get title => _title;
  String? get poster => _poster;
  String? get year => _year;
  String? get country => _country;
  String? get imdbRating => _imdbRating;
  List<String>? get genres => _genres;
  List<String>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['poster'] = _poster;
    map['year'] = _year;
    map['country'] = _country;
    map['imdb_rating'] = _imdbRating;
    map['genres'] = _genres;
    map['images'] = _images;
    return map;
  }
}
