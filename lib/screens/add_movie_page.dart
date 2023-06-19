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

class AddMoviePage extends HookWidget {
  const AddMoviePage({super.key});

  final buttonWidth = 200.0;
  @override
  Widget build(BuildContext context) {
    final movieName = useTextEditingController();

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Movie name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Director name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Country:',
                            style: TextStyle(fontSize: 19),
                          ),
                          TextButton(
                              onPressed: () {
                                countryPicker(context);
                              },
                              child: const Text(
                                'Select',
                                style: TextStyle(fontSize: 17),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Date:',
                            style: TextStyle(fontSize: 19),
                          ),
                          TextButton(
                              onPressed: () {
                                movieDatePicker(context);
                              },
                              child: const Text(
                                'Select',
                                style: TextStyle(fontSize: 17),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Movie Image:',
                            style: TextStyle(fontSize: 19),
                          ),
                          TextButton(
                              onPressed: () {
                                context.read<AppCubit>().addMovie();
                              },
                              child: const Text(
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
                          const Text(
                            'Movie rate:',
                            style: TextStyle(fontSize: 19),
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
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () {
                            context.read<AppCubit>().showLoadong();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.only(
                                bottom: 30, right: 20, left: 20),
                            child: const Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
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

  void countryPicker(
    BuildContext context,
  ) {
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
        print(index);
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
      onChange: (index) {
        print(index);
      },
      onSubmit: (index) {
        print(index);
      },
      maxDateTime: DateTime.now(),
      minDateTime: DateTime(1895),
      bottomPickerTheme: BottomPickerTheme.blue,
    ).show(context);
  }
}
