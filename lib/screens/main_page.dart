import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                onPressed: () {
                  context.push('/postList');
                },
                child: const Text(
                  'Go to post list page',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  context.push('/counter');
                },
                child: const Text(
                  'Go to counter page',
                  style: TextStyle(fontSize: 22),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
