import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickstep_app/models/movement.dart';
import 'package:quickstep_app/screens/movements/create_movement.dart';
import 'package:quickstep_app/utils/helpers.dart';

import 'widgets/movement_tile.dart';

class MovementsPage extends StatefulWidget {
  const MovementsPage({super.key});

  @override
  State<MovementsPage> createState() => _MovementsPageState();
}

class _MovementsPageState extends State<MovementsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Movements",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  pushPage(context, to: const CreateMovementPage());
                },
                icon: const Icon(Icons.add),
                label: const Text("Create"),
              )
            ],
          ),
          for (var i = 0; i < dummyMovements.length; i++)
            MovementTile(movement: dummyMovements[i]),
        ],
      ),
    );
  }
}
