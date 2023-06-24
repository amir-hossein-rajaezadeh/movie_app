import 'dart:ui';

import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:bloc_getit_practice/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../cubit/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/colors.dart';

class MovieListPage extends HookWidget {
  MovieListPage({super.key});
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final searchTextFieldController = useTextEditingController();
    final size = MediaQuery.of(context).size;

    context.read<AppCubit>().onSearch(searchTextFieldController);
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          print('reach end of the list');
          context.read<AppCubit>().updatePage(searchTextFieldController.text);
        }
      }
    });

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Stack(
              children: [
                SizedBox(
                  height: 325,
                  width: size.width,
                  child: Image.network(
                    'http://moviesapi.ir/images/tt0041959_poster.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  
                  child: Container(

                    height: 325,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 325),
                  height: 50,
                  color: const Color(0xFF1a1a1a),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: AppTheme.getTextTheme(null)
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Amirhosein',
                                style: AppTheme.getTextTheme(null)
                                    .displaySmall!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 20, bottom: 15),
                          child: Row(
                            children: const [
                              Icon(
                                CupertinoIcons.bell,
                                color: Colors.white,
                                size: 28,
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Icon(
                                CupertinoIcons.search,
                                color: Colors.white,
                                size: 28,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    AnimatedContainer(
                      margin: const EdgeInsets.only(top: 20),
                      duration: const Duration(milliseconds: 200),
                      height: 200,
                      child: PageView.builder(
                        itemCount: 10,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged:
                            context.read<AppCubit>().onPageViewChange,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          'http://moviesapi.ir/images/tt0041959_poster.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        bottomLeft: Radius.circular(18),
                                      ),
                                    ),
                                    width: size.width * .50,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 15.0, sigmaY: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          liveNowWidget(),
                                          movieInfo()
                                        ],
                                      ),
                                    )),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(18),
                                      bottomRight: Radius.circular(18),
                                    ),
                                    child: Image.network(
                                      fit: BoxFit.cover,
                                      'http://moviesapi.ir/images/tt0041959_poster.jpg',
                                      height: size.height,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget movieInfo() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'MovieName',
          style: AppTheme.getTextTheme(null)
              .labelLarge!
              .copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'MovieDesc',
          style: AppTheme.getTextTheme(null)
              .bodyLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            color: blue,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(
            child: Text(
              AppConstants.watchNow,
              style: AppTheme.getTextTheme(null)
                  .bodySmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Widget liveNowWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 0),
      height: 18,
      width: 90,
      decoration: BoxDecoration(
        color: const Color(0xFFffdedf),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100), color: red),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              AppConstants.liveNow,
              style:
                  AppTheme.getTextTheme(null).titleMedium!.copyWith(color: red),
            ),
          ],
        ),
      ),
    );
  }
}

  //   return SafeArea(
  //     child: Scaffold(
  //       floatingActionButton: FloatingActionButton(
  //         onPressed: () {
  //           context.push('/addMovie');
  //         },
  //         child: const Icon(Icons.add),
  //       ),
  //       body: BlocBuilder<AppCubit, AppState>(
  //         builder: (context, state) {
  //           final movie = state.movieList;
  //           return Column(
  //             children: [
  //               if (state.movieList.isNotEmpty)
  //                 Container(
  //                   margin:
  //                       const EdgeInsets.only(right: 20, left: 20, bottom: 10),
  //                   width: width,
  //                   child: Container(
  //                     margin: const EdgeInsets.only(top: 12),
  //                     child: TextField(
  //                       controller: searchTextFieldController,
  //                       textInputAction: TextInputAction.search,
  //                       decoration: InputDecoration(
  //                         hintText: 'Search movie',
  //                         suffixIcon: InkWell(
  //                           onTap: () {
  //                             String searchValue =
  //                                 searchTextFieldController.text;

  //                             context.read<AppCubit>().searchMovie(searchValue);
  //                           },
  //                           child: const Icon(Icons.search),
  //                         ),
  //                         border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(12),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               Expanded(
  //                 child: Stack(
  //                   children: [
  //                     if (movie.isEmpty && !state.isLoading)
  //                       Center(
  //                         child: TextButton(
  //                           onPressed: () {
  //                             context.read<AppCubit>().fetchMovieApi();
  //                           },
  //                           child: const Text(
  //                             "Load Json",
  //                             style: TextStyle(fontSize: 20),
  //                           ),
  //                         ),
  //                       )
  //                     else
  //                       ListView.separated(
  //                         shrinkWrap: true,
  //                         controller: scrollController,
  //                         itemCount: movie.length,
  //                         separatorBuilder: (context, index) {
  //                           return Container(
  //                             margin: const EdgeInsets.symmetric(vertical: 3),
  //                             height: 1.5,
  //                             color: Colors.grey,
  //                           );
  //                         },
  //                         itemBuilder: (context, index) {
  //                           final movieItem = movie[index];
  //                           return Container(
  //                             margin: const EdgeInsets.only(left: 15),
  //                             child: InkWell(
  //                               onTap: () {},
  //                               child: Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   SizedBox(
  //                                     width: width * .6,
  //                                     child: Column(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       children: [
  //                                         Text(
  //                                           movieItem.id.toString(),
  //                                           maxLines: 2,
  //                                           overflow: TextOverflow.ellipsis,
  //                                           style: const TextStyle(
  //                                               fontSize: 18,
  //                                               color: Colors.black),
  //                                         ),
  //                                         const SizedBox(
  //                                           height: 15,
  //                                         ),
  //                                         Text(
  //                                           movieItem.country!,
  //                                           overflow: TextOverflow.ellipsis,
  //                                           style: const TextStyle(
  //                                               fontSize: 18,
  //                                               color: Colors.black),
  //                                         ),
  //                                         const SizedBox(
  //                                           height: 15,
  //                                         ),
  //                                         SizedBox(
  //                                           height: 20,
  //                                           width: width * .5,
  //                                           child: ListView.separated(
  //                                             separatorBuilder:
  //                                                 (context, index) {
  //                                               return Container(
  //                                                 margin: const EdgeInsets
  //                                                     .symmetric(horizontal: 5),
  //                                                 width: 2,
  //                                                 height: 20,
  //                                                 color: Colors.grey,
  //                                               );
  //                                             },
  //                                             scrollDirection: Axis.horizontal,
  //                                             itemCount:
  //                                                 movieItem.genres?.length ?? 0,
  //                                             itemBuilder: (context, index) {
  //                                               return Text(
  //                                                 movieItem.genres?[index] ??
  //                                                     "",
  //                                                 style: const TextStyle(
  //                                                     fontSize: 18),
  //                                               );
  //                                             },
  //                                           ),
  //                                         )
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     margin: const EdgeInsets.only(
  //                                         right: 15, top: 6, bottom: 4),
  //                                     child: Column(
  //                                       children: [
  //                                         ClipRRect(
  //                                           borderRadius:
  //                                               BorderRadius.circular(12),
  //                                           child: Image.network(
  //                                             movie[index].poster!,
  //                                             width: width * .15,
  //                                             height: 80,
  //                                             fit: BoxFit.cover,
  //                                           ),
  //                                         ),
  //                                         const SizedBox(
  //                                           height: 6,
  //                                         ),
  //                                         Text(
  //                                           movieItem.year!,
  //                                           style: const TextStyle(
  //                                               fontSize: 15,
  //                                               color: Colors.black),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     if (state.isLoading)
  //                       const Center(
  //                         child: CircularProgressIndicator(),
  //                       )
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }
// }
