import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:quickstep_app/routes/router.gr.dart';
import 'package:quickstep_app/utils/colors.dart';

import 'components/home_listview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hey 👋,\nExplore what's new today?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: ((context, index) {
                  return Container(
                    width: 115,
                    margin: const EdgeInsets.only(right: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: lightPrimary,
                      image: const DecorationImage(
                        image: AssetImage("assets/images/map.jpeg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.linearToSrgbGamma(),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: veryLightGrey,
                                blurRadius: 50,
                                offset: Offset(-2, -2),
                              )
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 1.5,
                          ),
                          child: const Text(
                            "On going",
                            style: TextStyle(
                              fontSize: 12,
                              color: white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: primary,
                          foregroundColor: white,
                          child: Text("Q"),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          "Quality",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: white,
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.router.push(
                      SingleHomeRoute(
                        homeId: "Amata yaraye",
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Explore more"),
                ),
              ),
            ),
            Text(
              "Travels",
              style: TextStyle(
                fontSize: 23,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w700,
              ),
            ),
            const HomeListView(),
            Text(
              "Orders",
              style: TextStyle(
                fontSize: 23,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w700,
              ),
            ),
            const HomeListView(),
            Text(
              "Bus Tracking",
              style: TextStyle(
                fontSize: 23,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w700,
              ),
            ),
            const HomeListView(),
          ],
        ),
      ),
    );
  }
}


//context.navigateTo(PostsRouter(children:[
//SinglePostRoute(postId: id)]))