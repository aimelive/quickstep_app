import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quickstep_app/screens/home/components/movements/on_loading.dart';

import '../../../../controllers/movements_controller.dart';
import 'movement_story_card.dart';

class FeaturedMovements extends StatefulWidget {
  const FeaturedMovements({
    Key? key,
  }) : super(key: key);

  @override
  State<FeaturedMovements> createState() => _FeaturedMovementsState();
}

class _FeaturedMovementsState extends State<FeaturedMovements> {
  final movementController = Get.put(MovementController());

  @override
  void initState() {
    movementController.getMovements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: movementController.obx(
        (state) {
          if (state == null) {
            return const OnLoadingStories();
          }
          final moves = state;
          moves.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          if (moves.isEmpty) {
            return const OnLoadingStories();
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: moves.length,
            itemBuilder: ((context, index) {
              return MovementStoryCard(
                movement: moves[index],
                mounted: mounted,
              );
            }),
          );
        },
        onLoading: const OnLoadingStories(),
        onEmpty: const OnLoadingStories(),
        onError: (error) => Text("$error"),
      ),
    );
  }
}
