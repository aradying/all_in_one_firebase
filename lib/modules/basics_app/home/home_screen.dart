import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text(
          'First App',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // print('search icon clicked');
            },
          ),
          IconButton(
            icon: const Icon(Icons.notification_important),
            onPressed: () {
              // print('notification icon clicked');
            },
          ),
        ],
      ),
    );
  }
}
