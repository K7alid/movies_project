import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_project/layout/cubit/cubit.dart';
import 'package:movies_project/layout/cubit/states.dart';
import 'package:movies_project/layout/search_screen.dart';
import 'package:movies_project/shared/components.dart';

class MoviesScreen extends StatelessWidget {
  MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MoviesCubit(),
      child: BlocConsumer<MoviesCubit, MoviesStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (MoviesCubit.get(context).movies.isEmpty) {
            MoviesCubit.get(context).mostPopularMovies();
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Moves'),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    MoviesCubit.get(context).signOut(context);
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                  ),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: MoviesCubit.get(context).movies.isNotEmpty,
              builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildMovieProperties(
                    MoviesCubit.get(context).movies, index, context),
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: MoviesCubit.get(context).movies.length,
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}

Widget buildMovieProperties(moves, index, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                  moves[index].image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  moves[index].fullTitle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  moves[index].crew,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  moves[index].imDbRating,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  moves[index].imDbRatingCount,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
