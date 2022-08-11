import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_project/layout/cubit/states.dart';
import 'package:movies_project/login/login_screen.dart';
import 'package:movies_project/shared/cache_helper.dart';
import 'package:movies_project/shared/components.dart';
import 'package:movies_project/shared/movies_model.dart';

class MoviesCubit extends Cubit<MoviesStates> {
  MoviesCubit() : super(AppInitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);

  void signOut(context) {
    CacheHelper.removeData(
      key: 'uId',
    ).then((value) {
      navigateAndFinish(context, LoginScreen());
    });
  }

  List<Items> movies = [];

  Future<List<Items>> fetchMovies() async {
    final response = await http.get(Uri.parse(
        'https://imdb-api.com/en/API/MostPopularMovies/k_p66y3rye')); //k_yvc88b3q k_lzgmbjke k_62no27k4 k_p66y3rye

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result['items'];
      emit(GetMoviesLoadingState());
      return list.map((e) => Items.fromJson(e)).toList();
    } else {
      throw Exception('failed');
    }
  }

  void mostPopularMovies() async {
    final myMovies = await fetchMovies();
    movies.addAll(myMovies);
    emit(GetMoviesSuccessState());
  }

  List<Items> search = [];

  Future<List<Items>> fetchSearch({
    required String value,
  }) async {
    final response = await http.get(Uri.parse(
        'https://imdb-api.com/en/API/SearchMovie/k_p66y3rye/$value')); //k_yvc88b3q  k_lzgmbjke

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result['items'];
      emit(GetSearchLoadingState());
      return list.map((e) => Items.fromJson(e)).toList();
    } else {
      throw Exception('failed');
    }
  }

  void getSearch({
    required String value,
  }) async {
    final myMovies = await fetchSearch(value: value);
    search.addAll(myMovies);
    emit(GetSearchSuccessState());
  }
}
////////////////////////////////////////////////////////////////
/*late Future<List<Welcome>> futurePost;

  Future<List<Welcome>> fetchPost() async {
    final response = await http.get(
        Uri.parse('https://imdb-api.com/en/API/MostPopularMovies/k_yvc88b3q'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Welcome>((json) => Welcome.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }*/

/*List<dynamic> moves = [];

  void getMovies() {
    emit(GetMoviesLoadingState());

    if (moves.isEmpty) {
      DioHelper.getData(
        url: 'en/API/MostPopularMovies/k_yvc88b3q',
      ).then((value) {
        moves = value.data;
        print(value);
        print(value.data);
        print(moves);
        emit(GetMoviesSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetMoviesErrorState());
      });
    } else {
      emit(GetMoviesSuccessState());
    }
  }*/

/*
cupertino_icons: ^1.0.2
  conditional_builder_null_safety: ^0.0.6
  bloc: ^8.0.3
  flutter_bloc: ^8.0.1
  fluttertoast: ^8.0.9
  image_picker: ^0.8.5
  shared_preferences: ^2.0.13
  hexcolor: ^2.0.7
  #firebase
  firebase_core: ^1.15.0
  firebase_auth: ^3.3.16
  cloud_firestore: ^3.1.14
  firebase_storage: ^10.2.15
  firebase_messaging: ^11.3.0
 */
