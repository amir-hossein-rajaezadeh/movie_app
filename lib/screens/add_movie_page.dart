import 'dart:io';

import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:bloc_getit_practice/utils/app_constants.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../cubit/app_state.dart';
import '../utils/app_theme.dart';
import '../utils/colors.dart';

class AddMoviePage extends HookWidget {
  const AddMoviePage({super.key});
  @override
  Widget build(BuildContext context) {
    final movieName = useTextEditingController();
    final movieDirector = useTextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: greyBackground,
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 40, right: 20, left: 20),
                            child: TextField(
                              controller: movieName,
                              decoration: InputDecoration(
                                labelText: 'Movie name',
                                labelStyle: AppTheme.getTextTheme(null)
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, right: 20, left: 20),
                            child: TextField(
                              controller: movieDirector,
                              decoration: InputDecoration(
                                labelText: 'Director name',
                                labelStyle: AppTheme.getTextTheme(null)
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Country:',
                                  style: AppTheme.getTextTheme(null)
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 19, color: Colors.white),
                                ),
                                TextButton(
                                    onPressed: () {
                                      countryPicker(
                                        context,
                                      );
                                    },
                                    child: Text(
                                      state.selectedCountryName ?? 'Select',
                                      style: const TextStyle(fontSize: 17),
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Date:',
                                  style: AppTheme.getTextTheme(null)
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 19, color: Colors.white),
                                ),
                                TextButton(
                                    onPressed: () {
                                      movieDatePicker(context);
                                    },
                                    child: Text(
                                      state.selectedMovieDate ?? 'Select',
                                      style: const TextStyle(fontSize: 17),
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 20, right: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Movie Image:',
                                  style: AppTheme.getTextTheme(null)
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 19, color: Colors.white),
                                ),
                                TextButton(
                                    onPressed: () {
                                      context.read<AppCubit>().selectImage();
                                    },
                                    child: state.selectedImage != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.file(
                                              File(state.selectedImage!),
                                              height: 80,
                                              width: 70,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : const Text(
                                            'Select',
                                            style: TextStyle(fontSize: 17),
                                          ))
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Movie rate:',
                                  style: AppTheme.getTextTheme(null)
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 19, color: Colors.white),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 140,
                                  child: RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemSize: 25,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      context
                                          .read<AppCubit>()
                                          .setMovieRate(rating.toInt());

                                      print(rating);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.only(
                          bottom: 30, right: 20, left: 20),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            context.read<AppCubit>().addMovie(
                                movieName.text, movieDirector.text, context);
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
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

  void countryPicker(BuildContext context) {
    List<Text> countryTextWidgetList = [];
    for (var element in AppConstants.countryList) {
      countryTextWidgetList.add(Text(element));
    }

    BottomPicker(
      height: 250,
      items: countryTextWidgetList,
      dismissable: true,
      title: 'Choose movier country',
      bottomPickerTheme: BottomPickerTheme.morningSalad,
      onSubmit: (index) {
        context
            .read<AppCubit>()
            .setSelectedCountryName(index, AppConstants.countryList);
      },
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Color(0xFF50A7C2),
      ),
      pickerTextStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      displayButtonIcon: true,
      displayCloseIcon: false,
      displaySubmitButton: true,
    ).show(context);
  }

  void movieDatePicker(BuildContext context) {
    BottomPicker.date(
      height: 250,
      title: 'Set Movie Date',
      dismissable: true,
      dateOrder: DatePickerDateOrder.dmy,
      pickerTextStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.blue,
      ),
      initialDateTime: DateTime(
          context.read<AppCubit>().returnYear(),
          context.read<AppCubit>().returnMonth(),
          context.read<AppCubit>().returnDay()),
      onSubmit: (date) {
        context.read<AppCubit>().setSelectedMovieDate(
              date.toString(),
            );
      },
      maxDateTime: DateTime.now(),
      minDateTime: DateTime(1895),
      bottomPickerTheme: BottomPickerTheme.blue,
    ).show(context);
  }
}
