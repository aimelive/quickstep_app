import 'package:flutter/material.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text("Activities goes here"),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Click to go to single activity"),
            )
          ],
        ),
      ),
    );
  }
}
