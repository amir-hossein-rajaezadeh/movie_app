import 'package:bloc_getit_practice/models/movie_rm.dart';
import 'package:bloc_getit_practice/utils/app_theme.dart';
import 'package:bloc_getit_practice/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieDetailPage extends StatelessWidget {
  MovieRM? selectedMovieItem;

  MovieDetailPage({super.key, required this.selectedMovieItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                        selectedMovieItem!.poster!,
                        fit: BoxFit.cover,
                        width: size.width,
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 22, right: 18, left: 18),
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
                        selectedMovieItem!.title ?? "",
                        style: AppTheme.getTextTheme(null)
                            .bodyLarge!
                            .copyWith(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
