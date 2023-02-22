import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SingleActivityPage extends StatelessWidget {
  const SingleActivityPage({
    super.key,
    @PathParam() required this.activityId,
  });

  final String activityId;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade400,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "This is single activity and one page",
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
