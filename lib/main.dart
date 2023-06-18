import 'package:bloc_getit_practice/cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/app_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AppCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Practice'),
          ),
          body: Stack(
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
                      )),
                ],
              ),
              if (state.isLoading)
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                )
            ],
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
      },
    );
  }
}
