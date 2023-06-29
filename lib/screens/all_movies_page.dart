import 'package:bloc_getit_practice/models/movie_rm.dart';
import 'package:bloc_getit_practice/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../cubit/app_cubit.dart';
import '../cubit/app_state.dart';
import 'components/app_bar.dart';

class AllMoviesPage extends StatefulHookWidget {
  const AllMoviesPage({super.key});

  @override
  State<AllMoviesPage> createState() => _AllMoviesPageState();
}

class _AllMoviesPageState extends State<AllMoviesPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    if (context.read<AppCubit>().getdebounce() != null) {
      context.read<AppCubit>().getdebounce()!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchTextFieldController = useTextEditingController();
    final size = MediaQuery.of(context).size;
    context.read<AppCubit>().onTextChange(searchTextFieldController);
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
        backgroundColor: const Color(0xFF1d1c1c),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/addMovie');
          },
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
             return Column(
              children: [
                if (state.movieList.isNotEmpty)
                  AppBarWidget(
                      size: size,
                      searchTextFieldController: searchTextFieldController,
                      haveSearchTextField: true),
                movieListWidget(    size, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget movieListWidget(  Size size, AppState state) {
    return Expanded(
      child: Stack(
        children: [
          ListView.separated(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: state.movieList.length,
            separatorBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                height: 1.5,
                color: Colors.grey,
              );
            },
            itemBuilder: (context, index) {
              final movieItem = state.movieList[index];
              return Container(
                margin: const EdgeInsets.only(left: 15),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * .6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movieItem.title ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.getTextTheme(null)
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              movieItem.country!,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.getTextTheme(null)
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 20,
                              width: size.width * .5,
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    width: 2,
                                    height: 20,
                                    color: Colors.grey,
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: movieItem.genres?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Text(
                                    movieItem.genres?[index] ?? "",
                                    style: AppTheme.getTextTheme(null)
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(right: 15, top: 6, bottom: 4),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                state.movieList[index].poster!,
                                width: size.width * .15,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(movieItem.year!,
                                style: AppTheme.getTextTheme(null)
                                    .titleMedium!
                                    .copyWith(color: Colors.white)),
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
    );
  }
}
