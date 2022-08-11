import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_project/layout/movies_screen.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (MoviesCubit.get(context).search.isEmpty) {
          MoviesCubit.get(context).mostPopularMovies();
        }

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextFormField(
                  onChange: (String value) {
                    MoviesCubit.get(context).getSearch(
                      value: value,
                    );
                  },
                  text: 'Search',
                  prefix: Icons.search,
                  textInputType: TextInputType.text,
                  controller: searchController,
                  validate: (value) {
                    if (value.isEmpty) {
                      return 'Search musn\'t be empty';
                    }
                  },
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: MoviesCubit.get(context).search.isNotEmpty,
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => buildMovieProperties(
                        MoviesCubit.get(context).search, index, context),
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: MoviesCubit.get(context).search.length,
                  ),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget defaultTextFormField({
  required String text,
  required IconData prefix,
  IconData? suffix,
  double radius = 0.0,
  required TextInputType textInputType,
  required var controller,
  var onSubmitted,
  var onChange,
  Function()? onTap,
  required validate,
  var onSuffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      obscureText: isPassword,
      validator: validate,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChange,
      onTap: onTap,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        labelText: text,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: onSuffixPressed,
              )
            : null,
      ),
    );
