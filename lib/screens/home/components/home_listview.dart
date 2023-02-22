import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      height: 200,
      child: ListView.builder(
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return Container(
            decoration: BoxDecoration(
              color: lightPrimary,
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage("assets/images/map.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            width: 230,
            margin: const EdgeInsets.only(right: 10),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      // color: Colors.blue,
                      child: Stack(
                        children: const [
                          Positioned(
                            top: 5,
                            left: 5,
                            child: CircleAvatar(
                              foregroundImage: AssetImage(
                                "assets/images/aime.png",
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 15,
                            child: CircleAvatar(
                              foregroundImage: AssetImage(
                                "assets/images/aime.png",
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 80,
                            child: CircleAvatar(
                              radius: 30,
                              foregroundImage: AssetImage(
                                "assets/images/aime.png",
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            left: 25,
                            child: CircleAvatar(
                              foregroundImage: AssetImage(
                                "assets/images/aime.png",
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            right: 30,
                            child: CircleAvatar(
                              foregroundImage: AssetImage(
                                "assets/images/aime.png",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        // context.navigateTo(
                        //   MovementsRouter(
                        //     children: [
                        //       CreateMovementRoute(liveId: "we're live now"),
                        //     ],
                        //   ),
                        // );
                      },
                      child: const Text("View order"),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
