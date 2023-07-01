import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:bloc_getit_practice/utils/app_constants.dart';
import 'package:bloc_getit_practice/utils/image_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/app_state.dart';
import '../utils/app_theme.dart';
import 'components/app_bar.dart';

class GenreListPage extends StatelessWidget {
  GenreListPage({super.key, required this.genreName});
  String genreName;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          print('reach end of the list');
          // context.read<AppCubit>().updatePage(searchTextFieldController.text);
        }
      }
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1d1c1c),
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final size = MediaQuery.of(context).size;
            return Column(
              children: [
                AppBarWidget(
                  size: size,
                  haveSearchTextField: false,
                  selectedGenreName: AppConstants.Genres,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        controller: scrollController,
                        itemCount: state.genreList.length,
                        separatorBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            height: 1.5,
                            color: Colors.grey,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: InkWell(
                              onTap: () async {
                                
                                await context
                                    .read<AppCubit>()
                                    .getGenreMovieById(
                                        state.genreList[index].id!);
                                context.push(
                                  '/allMoviesPage',
                                  extra: state.genreList[index],
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: size.width * .4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.genreList[index].name ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTheme.getTextTheme(null)
                                              .bodyLarge!
                                              .copyWith(color: Colors.white),
                                        ),
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
                                            genreList[index],
                                            width: size.width * .5,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
