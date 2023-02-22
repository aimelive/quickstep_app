import 'package:flutter/material.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text("Groups goes here"),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Click to go to single group"),
            )
          ],
        ),
      ),
    );
  }
}
