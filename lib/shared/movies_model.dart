class MoviesModel {
  List<Items>? items;
  String? errorMessage;

  MoviesModel({this.items, this.errorMessage});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        //add(Items.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }
}

class Items {
  String id;
  String rank;
  String rankUpDown;
  String title;
  String fullTitle;
  String year;
  String image;
  String crew;
  String imDbRating;
  String imDbRatingCount;

  Items({
    required this.id,
    required this.rank,
    required this.rankUpDown,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.image,
    required this.crew,
    required this.imDbRating,
    required this.imDbRatingCount,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      rank: json['rank'],
      rankUpDown: json['rankUpDown'],
      title: json['title'],
      fullTitle: json['fullTitle'],
      year: json['year'],
      image: json['image'],
      crew: json['crew'],
      imDbRating: json['imDbRating'],
      imDbRatingCount: json['imDbRatingCount'],
    );
  }
}
