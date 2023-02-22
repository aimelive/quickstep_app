import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CreateMovementPage extends StatelessWidget {
  const CreateMovementPage({
    super.key,
    @PathParam() required this.liveId,
  });
  final String liveId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "This is single movement and one page",
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
