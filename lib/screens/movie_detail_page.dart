import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:bloc_getit_practice/cubit/app_state.dart';
import 'package:bloc_getit_practice/models/movie_rm.dart';
import 'package:bloc_getit_practice/utils/app_theme.dart';
import 'package:bloc_getit_practice/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MovieDetailPage extends StatelessWidget {
  MovieRM? selectedMovieItem;

  MovieDetailPage({super.key, required this.selectedMovieItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12, left: 12, top: 20),
                    width: size.width,
                    height: 300,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            state.movieItem!.poster!,
                            fit: BoxFit.cover,
                            width: size.width,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 22, right: 18, left: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  context.pop();
                                },
                                child: const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.share,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 8),
                      width: size.width,
                      decoration: const BoxDecoration(
                        color: greyBackground,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 50,
                            height: 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white),
                          ),
                          Text(
                            state.movieItem!.title ?? "",
                            style: AppTheme.getTextTheme(null)
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          Container(
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  // state.movieItem!.runtime!,
                                  context.read<AppCubit>().movieTimeInHoure(),
                                  style: AppTheme.getTextTheme(null)
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  state.movieItem!.year.toString(),
                                  style: AppTheme.getTextTheme(null)
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 22,
                                    width: 100,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          width: 3,
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          state.movieItem!.genres!.length,
                                      itemBuilder: (context, index) {
                                        return Text(
                                          state.movieItem!.genres![index],
                                          style: AppTheme.getTextTheme(null)
                                              .bodyMedium!
                                              .copyWith(color: Colors.grey),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
