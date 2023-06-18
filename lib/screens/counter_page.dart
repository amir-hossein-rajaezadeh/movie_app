import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:bloc_getit_practice/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      state.text != ""
                          ? state.text
                          : 'You have pushed the button this many times:',
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.read<AppCubit>().changeText(),
                    child: Text(
                      state.counter.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
            ],
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 218, 19, 19),
            onPressed: () {
              context.read<AppCubit>().increaseNumber(false);
            },
            tooltip: 'Decreasement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 30,
          ),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 13, 182, 19),
            onPressed: () {
              context.read<AppCubit>().increaseNumber(true);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
