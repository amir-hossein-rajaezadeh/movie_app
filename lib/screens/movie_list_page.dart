import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_state.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final movie = state.movieModel;
            return Stack(
              children: [
                if (movie.movie.isEmpty && !state.isLoading)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.read<AppCubit>().fetchMovieApi();
                      },
                      child: const Text(
                        "Load Json",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    itemCount: movie.movie.length,
                    separatorBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        height: 1.5,
                        color: Colors.grey,
                      );
                    },
                    itemBuilder: (context, index) {
                      final movieItem = movie.movie[index];
                      return Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          movieItem.title,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ),
                if (state.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
