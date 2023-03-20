import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickstep_app/controllers/movements_controller.dart';
import 'package:quickstep_app/screens/movements/create_movement.dart';
import 'package:quickstep_app/screens/movements/widgets/on_empty.dart';
import 'package:quickstep_app/screens/movements/widgets/on_error.dart';
import 'package:quickstep_app/utils/helpers.dart';

import 'widgets/movement_tile.dart';

class MovementsPage extends StatefulWidget {
  const MovementsPage({super.key});

  @override
  State<MovementsPage> createState() => _MovementsPageState();
}

class _MovementsPageState extends State<MovementsPage> {
  final movementController = Get.put(MovementController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  movementController.obx(
                    (state) {
                      if (state == null) {
                        return const OnError();
                      }
                      final moves = state;
                      moves.sort((a, b) => b.createdAt.compareTo(a.createdAt));
                      if (moves.isEmpty) {
                        return const OnEmpty();
                      }
                      return Column(
                        children: moves
                            .map<Widget>(
                              (move) => MovementTile(movement: move),
                            )
                            .toList(),
                      );
                    },
                    onLoading: const Text("Loading, please wait..."),
                    onEmpty: const OnEmpty(),
                    onError: (error) => Text("$error"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
