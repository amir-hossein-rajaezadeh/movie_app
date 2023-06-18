import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:bloc_getit_practice/repository/api_repository.dart';
import 'package:bloc_getit_practice/screens/counter_page.dart';
import 'package:bloc_getit_practice/screens/main_page.dart';
import 'package:bloc_getit_practice/screens/movie_list_page.dart';
import 'package:bloc_getit_practice/screens/post_list_page.dart';
import 'package:bloc_getit_practice/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(
    MyApp(
      apiService: ApiService(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: "/movieList",
        builder: (context, state) => MovieListPage(),
      ),
      GoRoute(
        path: "/postList",
        builder: (context, state) => const PostListPage(),
      ),
      GoRoute(
        path: "/counter",
        builder: (context, state) => const CounterPage(),
      )
    ],
  );
  MyApp({required this.apiService, super.key});
  final ApiService apiService;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(
        ApiRepository(apiService),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: _router,
      ),
    );
  }
}
