import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:quickstep_app/screens/activities/activities_page.dart';
import 'package:quickstep_app/screens/activities/single_activity_page.dart';
import 'package:quickstep_app/screens/home/home_page.dart';
import 'package:quickstep_app/screens/home/single_home_page.dart';
import 'package:quickstep_app/screens/layout.dart';
import 'package:quickstep_app/screens/movements/movements_page.dart';
import 'package:quickstep_app/screens/movements/create_movement.dart';
import 'package:quickstep_app/screens/profile/single_profile_page.dart';

import '../screens/profile/profile_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: "Page,Route",
  routes: [
    AutoRoute(
      path: "/",
      page: LayoutPage,
      initial: true,
      children: [
        AutoRoute(
          path: "home",
          name: "HomeRouter",
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: HomePage,
            ),
            AutoRoute(
              path: ":homeId",
              page: SingleHomePage,
            ),
          ],
        ),
        AutoRoute(
          path: "activities",
          name: "ActivitiesRouter",
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: ActivitiesPage,
            ),
            AutoRoute(
              path: ":activityId",
              page: SingleActivityPage,
            ),
          ],
        ),
        // AutoRoute(
        //   path: "groups",
        //   name: "GroupsRouter",
        //   page: EmptyRouterPage,
        //   children: [
        //     AutoRoute(
        //       path: '',
        //       page: GroupsPage,
        //     ),
        //     AutoRoute(
        //       path: ":groupId",
        //       page: SingleGroupPage,
        //     ),
        //   ],
        // ),
        AutoRoute(
          path: "movements",
          name: "MovementsRouter",
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: MovementsPage,
            ),
            AutoRoute(
              path: ":liveId",
              page: CreateMovementPage,
            ),
          ],
        ),
        AutoRoute(
          path: "profile",
          name: "ProfileRouter",
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: ProfilePage,
            ),
            AutoRoute(
              path: ":profileId",
              page: SingleProfilePage,
            ),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
