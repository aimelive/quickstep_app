import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SingleProfilePage extends StatelessWidget {
  const SingleProfilePage({
    super.key,
    @PathParam() required this.profileId,
  });

  final String profileId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent.shade400,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Updated Profile Page",
              style: Theme.of(context).textTheme.headline5,
            ),
            const Text("Name:"),
            const Text("Email:"),
            const Text("Username:"),
          ],
        ),
      ),
    );
  }
}
