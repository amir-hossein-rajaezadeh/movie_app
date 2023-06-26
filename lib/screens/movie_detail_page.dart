import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:bloc_getit_practice/cubit/app_state.dart';
import 'package:bloc_getit_practice/models/movie_rm.dart';
import 'package:bloc_getit_practice/utils/app_constants.dart';
import 'package:bloc_getit_practice/utils/app_theme.dart';
import 'package:bloc_getit_practice/utils/colors.dart';
import 'package:flutter/cupertino.dart';
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 50,
                              height: 4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              state.movieItem!.title ?? "",
                              style: AppTheme.getTextTheme(null)
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 8),
                            child: Row(
                              children: [
                                Text(
                                  context.read<AppCubit>().movieTimeInHoure(),
                                  style: AppTheme.getTextTheme(null)
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  height: 18,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        width: 2,
                                      );
                                    },
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: state.movieItem!.genres!.length,
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
                                Text(
                                  state.movieItem!.year.toString(),
                                  style: AppTheme.getTextTheme(null)
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 18),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 12, right: 10),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 6),
                                        child: const Icon(
                                          CupertinoIcons.arrow_down_to_line_alt,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          AppConstants.download,
                                          style: AppTheme.getTextTheme(null)
                                              .bodySmall!
                                              .copyWith(color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 44,
                                    margin: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      color: purple,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppConstants.playNow,
                                        style: AppTheme.getTextTheme(null)
                                            .bodyLarge!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 22, right: 12, left: 12),
                            child: Text(
                              state.movieItem?.plot ?? '',
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.getTextTheme(null)
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, left: 20),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<AppCubit>()
                                        .onActorTapClicked();
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        AppConstants.actors,
                                        style: AppTheme.getTextTheme(null)
                                            .bodyLarge!
                                            .copyWith(
                                                color: state.actiorTabSelected
                                                    ? Colors.white
                                                    : Colors.grey,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      if (state.actiorTabSelected)
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5, left: 2),
                                          width: 65,
                                          height: 2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: purple),
                                        )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<AppCubit>()
                                        .onActorTapClicked();
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        child: Text(
                                          AppConstants.writer,
                                          style: AppTheme.getTextTheme(null)
                                              .bodyLarge!
                                              .copyWith(
                                                  color:
                                                      !state.actiorTabSelected
                                                          ? Colors.white
                                                          : Colors.grey,
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      if (!state.actiorTabSelected)
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 5, left: 27),
                                          width: 65,
                                          height: 2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: purple),
                                        )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),

                          // ListView.builder(itemBuilder: (context, index) {
                            
                          // },)
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
