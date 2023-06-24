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
  final PageController pageController = PageController();
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
        backgroundColor: Colors.transparent,
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Stack(
              children: [
                bluredBackgroundWidget(state, size),
                SingleChildScrollView(
                  child: Column(
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
                                  height: 10,
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
                            margin:
                                const EdgeInsets.only(right: 20, bottom: 20),
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
                      movieBannerWidget(context, size, state),
                      latestMoviesWidget(state),
                      topRatedWidget(state)
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

  Column bluredBackgroundWidget(AppState state, Size size) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Image.network(
            state.movieList[state.bannerPage!].poster!,
            fit: BoxFit.cover,
            height: 325,
            width: size.width,
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xFF1d1c1c),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 10),
          child: SizedBox(
            width: size.width,
          ),
        ),
      ],
    );
  }

  Column topRatedWidget(AppState state) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppConstants.topRated,
                style: AppTheme.getTextTheme(null)
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppConstants.seeAll,
                  style: AppTheme.getTextTheme(null).bodyMedium!,
                ),
              )
            ],
          ),
        ),
        Container(
          height: 150,
          margin: const EdgeInsets.only(bottom: 15),
          child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: index == 0 ? 20 : 0),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          state.movieList[index].poster!,
                          width: 250,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 12, bottom: 4),
                        width: 220,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.movieList[index].title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.getTextTheme(null)
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              state.movieList[index].year!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.getTextTheme(null)
                                  .bodySmall!
                                  .copyWith(color: Colors.grey, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: 12,
                );
              },
              itemCount: 10),
        )
      ],
    );
  }

  Widget movieBannerWidget(BuildContext context, Size size, AppState state) {
    return Column(
      children: [
        AnimatedContainer(
          margin: const EdgeInsets.only(top: 15),
          duration: const Duration(milliseconds: 200),
          height: 200,
          child: PageView.builder(
            controller: pageController,
            itemCount: state.movieList.length,
            physics: const BouncingScrollPhysics(),
            onPageChanged: context.read<AppCubit>().onPageViewChange,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, page) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            state.movieList[page].poster!,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                        ),
                      ),
                      width: size.width * .50,
                      margin: const EdgeInsets.only(left: 0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              bottomLeft: Radius.circular(18),
                            ),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                              child: const SizedBox(
                                width: 300,
                                height: 300,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                liveNowWidget(),
                                movieInfoWidget(state, page)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                        child: Image.network(
                          fit: BoxFit.cover,
                          state.movieList[page].poster!,
                          height: 200,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 10, left: 22, bottom: 10),
          height: 10,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: state.bannerPage == index
                        ? blue
                        : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(100)),
                width: 10,
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                width: 5,
              );
            },
            itemCount: state.movieList.length,
          ),
        )
      ],
    );
  }

  Widget latestMoviesWidget(AppState state) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppConstants.latesetMovies,
                style: AppTheme.getTextTheme(null)
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppConstants.seeAll,
                  style: AppTheme.getTextTheme(null).bodyMedium!,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 190,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: index == 0 ? 20 : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          state.movieList[index].poster!,
                          width: 90,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 90,
                        child: Text(
                          state.movieList[index].title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.getTextTheme(null)
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        state.movieList[index].year!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.getTextTheme(null)
                            .bodySmall!
                            .copyWith(color: Colors.grey),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  width: 12,
                );
              },
              itemCount: 10),
        )
      ],
    );
  }

  Widget movieInfoWidget(AppState state, int bannerItemIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          state.movieList[bannerItemIndex].title ?? '',
          textAlign: TextAlign.start,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.getTextTheme(null)
              .labelLarge!
              .copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 20,
          child: ListView.separated(
            separatorBuilder: (context, index) => Container(
              width: 10,
            ),
            itemCount: state.movieList[bannerItemIndex].genres!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Text(
                state.movieList[bannerItemIndex].genres![index],
                style: AppTheme.getTextTheme(null)
                    .titleMedium!
                    .copyWith(color: Colors.white),
              );
            },
          ),
        ),
        const SizedBox(
          height: 15,
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
      margin: const EdgeInsets.only(
        top: 18,
      ),
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
