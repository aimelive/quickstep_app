// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:auto_route/empty_router_widgets.dart' as _i2;
import 'package:flutter/material.dart' as _i14;

import '../screens/activities/activities_page.dart' as _i5;
import '../screens/activities/single_activity_page.dart' as _i6;
import '../screens/groups/groups_page.dart' as _i7;
import '../screens/groups/single_group_page.dart' as _i8;
import '../screens/home/home_page.dart' as _i3;
import '../screens/home/single_home_page.dart' as _i4;
import '../screens/layout.dart' as _i1;
import '../screens/movements/movements_page.dart' as _i9;
import '../screens/movements/create_movement.dart' as _i10;
import '../screens/profile/profile_page.dart' as _i11;
import '../screens/profile/single_profile_page.dart' as _i12;

class AppRouter extends _i13.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    LayoutRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LayoutPage(),
      );
    },
    HomeRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    ActivitiesRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    GroupsRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    LivesRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    ProfileRouter.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    SingleHomeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleHomeRouteArgs>(
          orElse: () =>
              SingleHomeRouteArgs(homeId: pathParams.getString('homeId')));
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.SingleHomePage(
          key: args.key,
          homeId: args.homeId,
        ),
      );
    },
    ActivitiesRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ActivitiesPage(),
      );
    },
    SingleActivityRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleActivityRouteArgs>(
          orElse: () => SingleActivityRouteArgs(
              activityId: pathParams.getString('activityId')));
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.SingleActivityPage(
          key: args.key,
          activityId: args.activityId,
        ),
      );
    },
    GroupsRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.GroupsPage(),
      );
    },
    SingleGroupRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleGroupRouteArgs>(
          orElse: () =>
              SingleGroupRouteArgs(groupId: pathParams.getString('groupId')));
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.SingleGroupPage(
          key: args.key,
          groupId: args.groupId,
        ),
      );
    },
    LivesRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.MovementsPage(),
      );
    },
    SingleLiveRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleLiveRouteArgs>(
          orElse: () =>
              SingleLiveRouteArgs(liveId: pathParams.getString('liveId')));
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.CreateMovementPage(
          key: args.key,
          liveId: args.liveId,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.ProfilePage(),
      );
    },
    SingleProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleProfileRouteArgs>(
          orElse: () => SingleProfileRouteArgs(
              profileId: pathParams.getString('profileId')));
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.SingleProfilePage(
          key: args.key,
          profileId: args.profileId,
        ),
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          LayoutRoute.name,
          path: '/',
          children: [
            _i13.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: LayoutRoute.name,
              children: [
                _i13.RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: HomeRouter.name,
                ),
                _i13.RouteConfig(
                  SingleHomeRoute.name,
                  path: ':homeId',
                  parent: HomeRouter.name,
                ),
              ],
            ),
            _i13.RouteConfig(
              ActivitiesRouter.name,
              path: 'activities',
              parent: LayoutRoute.name,
              children: [
                _i13.RouteConfig(
                  ActivitiesRoute.name,
                  path: '',
                  parent: ActivitiesRouter.name,
                ),
                _i13.RouteConfig(
                  SingleActivityRoute.name,
                  path: ':activityId',
                  parent: ActivitiesRouter.name,
                ),
              ],
            ),
            _i13.RouteConfig(
              GroupsRouter.name,
              path: 'groups',
              parent: LayoutRoute.name,
              children: [
                _i13.RouteConfig(
                  GroupsRoute.name,
                  path: '',
                  parent: GroupsRouter.name,
                ),
                _i13.RouteConfig(
                  SingleGroupRoute.name,
                  path: ':groupId',
                  parent: GroupsRouter.name,
                ),
              ],
            ),
            _i13.RouteConfig(
              LivesRouter.name,
              path: 'lives',
              parent: LayoutRoute.name,
              children: [
                _i13.RouteConfig(
                  LivesRoute.name,
                  path: '',
                  parent: LivesRouter.name,
                ),
                _i13.RouteConfig(
                  SingleLiveRoute.name,
                  path: ':liveId',
                  parent: LivesRouter.name,
                ),
              ],
            ),
            _i13.RouteConfig(
              ProfileRouter.name,
              path: 'profile',
              parent: LayoutRoute.name,
              children: [
                _i13.RouteConfig(
                  ProfileRoute.name,
                  path: '',
                  parent: ProfileRouter.name,
                ),
                _i13.RouteConfig(
                  SingleProfileRoute.name,
                  path: ':profileId',
                  parent: ProfileRouter.name,
                ),
              ],
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.LayoutPage]
class LayoutRoute extends _i13.PageRouteInfo<void> {
  const LayoutRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LayoutRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'LayoutRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class HomeRouter extends _i13.PageRouteInfo<void> {
  const HomeRouter({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class ActivitiesRouter extends _i13.PageRouteInfo<void> {
  const ActivitiesRouter({List<_i13.PageRouteInfo>? children})
      : super(
          ActivitiesRouter.name,
          path: 'activities',
          initialChildren: children,
        );

  static const String name = 'ActivitiesRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class GroupsRouter extends _i13.PageRouteInfo<void> {
  const GroupsRouter({List<_i13.PageRouteInfo>? children})
      : super(
          GroupsRouter.name,
          path: 'groups',
          initialChildren: children,
        );

  static const String name = 'GroupsRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class LivesRouter extends _i13.PageRouteInfo<void> {
  const LivesRouter({List<_i13.PageRouteInfo>? children})
      : super(
          LivesRouter.name,
          path: 'lives',
          initialChildren: children,
        );

  static const String name = 'LivesRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class ProfileRouter extends _i13.PageRouteInfo<void> {
  const ProfileRouter({List<_i13.PageRouteInfo>? children})
      : super(
          ProfileRouter.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRouter';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.SingleHomePage]
class SingleHomeRoute extends _i13.PageRouteInfo<SingleHomeRouteArgs> {
  SingleHomeRoute({
    _i14.Key? key,
    required String homeId,
  }) : super(
          SingleHomeRoute.name,
          path: ':homeId',
          args: SingleHomeRouteArgs(
            key: key,
            homeId: homeId,
          ),
          rawPathParams: {'homeId': homeId},
        );

  static const String name = 'SingleHomeRoute';
}

class SingleHomeRouteArgs {
  const SingleHomeRouteArgs({
    this.key,
    required this.homeId,
  });

  final _i14.Key? key;

  final String homeId;

  @override
  String toString() {
    return 'SingleHomeRouteArgs{key: $key, homeId: $homeId}';
  }
}

/// generated route for
/// [_i5.ActivitiesPage]
class ActivitiesRoute extends _i13.PageRouteInfo<void> {
  const ActivitiesRoute()
      : super(
          ActivitiesRoute.name,
          path: '',
        );

  static const String name = 'ActivitiesRoute';
}

/// generated route for
/// [_i6.SingleActivityPage]
class SingleActivityRoute extends _i13.PageRouteInfo<SingleActivityRouteArgs> {
  SingleActivityRoute({
    _i14.Key? key,
    required String activityId,
  }) : super(
          SingleActivityRoute.name,
          path: ':activityId',
          args: SingleActivityRouteArgs(
            key: key,
            activityId: activityId,
          ),
          rawPathParams: {'activityId': activityId},
        );

  static const String name = 'SingleActivityRoute';
}

class SingleActivityRouteArgs {
  const SingleActivityRouteArgs({
    this.key,
    required this.activityId,
  });

  final _i14.Key? key;

  final String activityId;

  @override
  String toString() {
    return 'SingleActivityRouteArgs{key: $key, activityId: $activityId}';
  }
}

/// generated route for
/// [_i7.GroupsPage]
class GroupsRoute extends _i13.PageRouteInfo<void> {
  const GroupsRoute()
      : super(
          GroupsRoute.name,
          path: '',
        );

  static const String name = 'GroupsRoute';
}

/// generated route for
/// [_i8.SingleGroupPage]
class SingleGroupRoute extends _i13.PageRouteInfo<SingleGroupRouteArgs> {
  SingleGroupRoute({
    _i14.Key? key,
    required String groupId,
  }) : super(
          SingleGroupRoute.name,
          path: ':groupId',
          args: SingleGroupRouteArgs(
            key: key,
            groupId: groupId,
          ),
          rawPathParams: {'groupId': groupId},
        );

  static const String name = 'SingleGroupRoute';
}

class SingleGroupRouteArgs {
  const SingleGroupRouteArgs({
    this.key,
    required this.groupId,
  });

  final _i14.Key? key;

  final String groupId;

  @override
  String toString() {
    return 'SingleGroupRouteArgs{key: $key, groupId: $groupId}';
  }
}

/// generated route for
/// [_i9.MovementsPage]
class LivesRoute extends _i13.PageRouteInfo<void> {
  const LivesRoute()
      : super(
          LivesRoute.name,
          path: '',
        );

  static const String name = 'LivesRoute';
}

/// generated route for
/// [_i10.CreateMovementPage]
class SingleLiveRoute extends _i13.PageRouteInfo<SingleLiveRouteArgs> {
  SingleLiveRoute({
    _i14.Key? key,
    required String liveId,
  }) : super(
          SingleLiveRoute.name,
          path: ':liveId',
          args: SingleLiveRouteArgs(
            key: key,
            liveId: liveId,
          ),
          rawPathParams: {'liveId': liveId},
        );

  static const String name = 'SingleLiveRoute';
}

class SingleLiveRouteArgs {
  const SingleLiveRouteArgs({
    this.key,
    required this.liveId,
  });

  final _i14.Key? key;

  final String liveId;

  @override
  String toString() {
    return 'SingleLiveRouteArgs{key: $key, liveId: $liveId}';
  }
}

/// generated route for
/// [_i11.ProfilePage]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i12.SingleProfilePage]
class SingleProfileRoute extends _i13.PageRouteInfo<SingleProfileRouteArgs> {
  SingleProfileRoute({
    _i14.Key? key,
    required String profileId,
  }) : super(
          SingleProfileRoute.name,
          path: ':profileId',
          args: SingleProfileRouteArgs(
            key: key,
            profileId: profileId,
          ),
          rawPathParams: {'profileId': profileId},
        );

  static const String name = 'SingleProfileRoute';
}

class SingleProfileRouteArgs {
  const SingleProfileRouteArgs({
    this.key,
    required this.profileId,
  });

  final _i14.Key? key;

  final String profileId;

  @override
  String toString() {
    return 'SingleProfileRouteArgs{key: $key, profileId: $profileId}';
  }
}
