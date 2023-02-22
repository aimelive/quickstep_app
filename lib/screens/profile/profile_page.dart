import 'package:flutter/material.dart';
import 'package:quickstep_app/routes/router.gr.dart';
import 'package:quickstep_app/utils/colors.dart';
import 'package:auto_route/auto_route.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // const MyAppBar(),
          ListTile(
            title: const Text("Aime Ndayambaje"),
            subtitle: const Text("Member since 12 Feb, 2022"),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                border: Border.all(
                  width: 3,
                  color: lightPrimary,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  context.router.push(
                    SingleProfileRoute(profileId: "mwiriwe ariko"),
                  );
                },
                child: const CircleAvatar(
                  radius: 25,
                  foregroundImage: AssetImage("assets/images/aime.png"),
                ),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Inactive"),
            subtitle: Text("Set your self as away"),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            subtitle: Text("Signed in as Aimelive"),
          ),
        ],
      ),
    );
  }
}
