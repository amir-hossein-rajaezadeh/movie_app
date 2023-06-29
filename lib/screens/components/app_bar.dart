import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../cubit/app_cubit.dart';
import '../../utils/app_theme.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget(
      {super.key,
      required this.size,
      this.searchTextFieldController,
      this.selectedGenreName,
      required this.haveSearchTextField});

  final Size size;
  final TextEditingController? searchTextFieldController;
  final bool haveSearchTextField;
  final String? selectedGenreName;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 10, bottom: 10),
      width: size.width,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Container(
              width: 35,
              height: 35,
              color: Colors.transparent,
              margin: const EdgeInsets.only(top: 8),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
          ),
          if (haveSearchTextField)
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 12, left: 15),
                child: TextField(
                  controller: searchTextFieldController,
                  style: AppTheme.getTextTheme(null)
                      .titleMedium!
                      .copyWith(color: Colors.white),
                  textInputAction: TextInputAction.search,
                  decoration: (const InputDecoration())
                      .applyDefaults(
                          AppTheme.getInputDecorationTheme(Brightness.dark))
                      .copyWith(
                          labelText: 'Search',
                          suffixIcon: InkWell(
                            onTap: () {
                              String searchValue =
                                  searchTextFieldController!.text;

                              context.read<AppCubit>().searchMovie(searchValue);
                            },
                            child: const Icon(Icons.search),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          contentPadding: const EdgeInsets.only(left: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          suffixIconColor: Colors.white),
                ),
              ),
            )
          else
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 10, top: 7),
              child: Text(
                selectedGenreName!,
                textAlign: TextAlign.left,
                style: AppTheme.getTextTheme(null)
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ))
        ],
      ),
    );
  }
}
