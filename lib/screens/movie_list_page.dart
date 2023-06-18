import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_state.dart';

class MovieListPage extends StatelessWidget {
  MovieListPage({super.key});
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          print('worasask');
          context.read<AppCubit>().updatePage();
        }
      }
    });

    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final movie = state.movieList;
            return Column(
              children: [
                if (state.movieList.isNotEmpty)
                  Container(
                    margin:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                    width: width,
                    child: Container(
                      margin: const EdgeInsets.only(top: 12),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: 'Search movie',
                          suffixIcon: InkWell(
                            onTap: () {},
                            child: const Icon(Icons.search),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Stack(
                    children: [
                      if (movie.isEmpty && !state.isLoading)
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
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount: movie.length,
                          separatorBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 3),
                              height: 1.5,
                              color: Colors.grey,
                            );
                          },
                          itemBuilder: (context, index) {
                            final movieItem = movie[index];
                            return Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width * .6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          movieItem.title ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          movieItem.country ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          height: 20,
                                          width: width * .5,
                                          child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                width: 2,
                                                height: 20,
                                                color: Colors.grey,
                                              );
                                            },
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                movieItem.genres?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return Text(
                                                movieItem.genres?[index] ?? "",
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        right: 15, top: 6, bottom: 4),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            movie[index].poster ?? "",
                                            width: width * .15,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          movieItem.year ?? "",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      if (state.isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
