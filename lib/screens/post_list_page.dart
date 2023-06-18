import 'package:bloc_getit_practice/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_state.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final post = state.postList;
            return Stack(
              children: [
                if (post.isEmpty && !state.isLoading)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.read<AppCubit>().fetchPostApi();
                      },
                      child: const Text(
                        "Load Json",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    itemCount: post.length,
                    separatorBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 3),
                        height: 1.5,
                        color: Colors.grey,
                      );
                    },
                    itemBuilder: (context, index) {
                      final postItem = post[index];
                      return Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Text(
                          postItem.body,
                          style: const TextStyle(fontSize: 20),
                        ),
                      );
                    },
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
}
