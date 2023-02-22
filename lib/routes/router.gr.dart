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
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:auto_route/empty_router_widgets.dart' as _i2;
import 'package:flutter/material.dart' as _i12;

import '../screens/activities/activities_page.dart' as _i5;
import '../screens/activities/single_activity_page.dart' as _i6;
import '../screens/home/home_page.dart' as _i3;
import '../screens/home/single_home_page.dart' as _i4;
import '../screens/layout.dart' as _i1;
import '../screens/movements/create_movement.dart' as _i8;
import '../screens/movements/movements_page.dart' as _i7;
import '../screens/profile/profile_page.dart' as _i9;
import '../screens/profile/single_profile_page.dart' as _i10;

class AppRouter extends _i11.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    LayoutRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.LayoutPage(),
      );
    },
    HomeRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    ActivitiesRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    MovementsRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    ProfileRouter.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.EmptyRouterPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    SingleHomeRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleHomeRouteArgs>(
          orElse: () =>
              SingleHomeRouteArgs(homeId: pathParams.getString('homeId')));
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.SingleHomePage(
          key: args.key,
          homeId: args.homeId,
        ),
      );
    },
    ActivitiesRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ActivitiesPage(),
      );
    },
    SingleActivityRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleActivityRouteArgs>(
          orElse: () => SingleActivityRouteArgs(
              activityId: pathParams.getString('activityId')));
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.SingleActivityPage(
          key: args.key,
          activityId: args.activityId,
        ),
      );
    },
    MovementsRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.MovementsPage(),
      );
    },
    CreateMovementRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CreateMovementRouteArgs>(
          orElse: () =>
              CreateMovementRouteArgs(liveId: pathParams.getString('liveId')));
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.CreateMovementPage(
          key: args.key,
          liveId: args.liveId,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.ProfilePage(),
      );
    },
    SingleProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SingleProfileRouteArgs>(
          orElse: () => SingleProfileRouteArgs(
              profileId: pathParams.getString('profileId')));
      return _i11.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.SingleProfilePage(
          key: args.key,
          profileId: args.profileId,
        ),
      );
    },
  };

  @override
  List<_i11.RouteConfig> get routes => [
        _i11.RouteConfig(
          LayoutRoute.name,
          path: '/',
          children: [
            _i11.RouteConfig(
              HomeRouter.name,
              path: 'home',
              parent: LayoutRoute.name,
              children: [
                _i11.RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: HomeRouter.name,
                ),
                _i11.RouteConfig(
                  SingleHomeRoute.name,
                  path: ':homeId',
                  parent: HomeRouter.name,
                ),
              ],
            ),
            _i11.RouteConfig(
              ActivitiesRouter.name,
              path: 'activities',
              parent: LayoutRoute.name,
              children: [
                _i11.RouteConfig(
                  ActivitiesRoute.name,
                  path: '',
                  parent: ActivitiesRouter.name,
                ),
                _i11.RouteConfig(
                  SingleActivityRoute.name,
                  path: ':activityId',
                  parent: ActivitiesRouter.name,
                ),
              ],
            ),
            _i11.RouteConfig(
              MovementsRouter.name,
              path: 'movements',
              parent: LayoutRoute.name,
              children: [
                _i11.RouteConfig(
                  MovementsRoute.name,
                  path: '',
                  parent: MovementsRouter.name,
                ),
                _i11.RouteConfig(
                  CreateMovementRoute.name,
                  path: ':liveId',
                  parent: MovementsRouter.name,
                ),
              ],
            ),
            _i11.RouteConfig(
              ProfileRouter.name,
              path: 'profile',
              parent: LayoutRoute.name,
              children: [
                _i11.RouteConfig(
                  ProfileRoute.name,
                  path: '',
                  parent: ProfileRouter.name,
                ),
                _i11.RouteConfig(
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
class LayoutRoute extends _i11.PageRouteInfo<void> {
  const LayoutRoute({List<_i11.PageRouteInfo>? children})
      : super(
          LayoutRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'LayoutRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class HomeRouter extends _i11.PageRouteInfo<void> {
  const HomeRouter({List<_i11.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class ActivitiesRouter extends _i11.PageRouteInfo<void> {
  const ActivitiesRouter({List<_i11.PageRouteInfo>? children})
      : super(
          ActivitiesRouter.name,
          path: 'activities',
          initialChildren: children,
        );

  static const String name = 'ActivitiesRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class MovementsRouter extends _i11.PageRouteInfo<void> {
  const MovementsRouter({List<_i11.PageRouteInfo>? children})
      : super(
          MovementsRouter.name,
          path: 'movements',
          initialChildren: children,
        );

  static const String name = 'MovementsRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class ProfileRouter extends _i11.PageRouteInfo<void> {
  const ProfileRouter({List<_i11.PageRouteInfo>? children})
      : super(
          ProfileRouter.name,
          path: 'profile',
          initialChildren: children,
        );

  static const String name = 'ProfileRouter';
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i4.SingleHomePage]
class SingleHomeRoute extends _i11.PageRouteInfo<SingleHomeRouteArgs> {
  SingleHomeRoute({
    _i12.Key? key,
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

  final _i12.Key? key;

  final String homeId;

  @override
  String toString() {
    return 'SingleHomeRouteArgs{key: $key, homeId: $homeId}';
  }
}

/// generated route for
/// [_i5.ActivitiesPage]
class ActivitiesRoute extends _i11.PageRouteInfo<void> {
  const ActivitiesRoute()
      : super(
          ActivitiesRoute.name,
          path: '',
        );

  static const String name = 'ActivitiesRoute';
}

/// generated route for
/// [_i6.SingleActivityPage]
class SingleActivityRoute extends _i11.PageRouteInfo<SingleActivityRouteArgs> {
  SingleActivityRoute({
    _i12.Key? key,
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

  final _i12.Key? key;

  final String activityId;

  @override
  String toString() {
    return 'SingleActivityRouteArgs{key: $key, activityId: $activityId}';
  }
}

/// generated route for
/// [_i7.MovementsPage]
class MovementsRoute extends _i11.PageRouteInfo<void> {
  const MovementsRoute()
      : super(
          MovementsRoute.name,
          path: '',
        );

  static const String name = 'MovementsRoute';
}

/// generated route for
/// [_i8.CreateMovementPage]
class CreateMovementRoute extends _i11.PageRouteInfo<CreateMovementRouteArgs> {
  CreateMovementRoute({
    _i12.Key? key,
    required String liveId,
  }) : super(
          CreateMovementRoute.name,
          path: ':liveId',
          args: CreateMovementRouteArgs(
            key: key,
            liveId: liveId,
          ),
          rawPathParams: {'liveId': liveId},
        );

  static const String name = 'CreateMovementRoute';
}

class CreateMovementRouteArgs {
  const CreateMovementRouteArgs({
    this.key,
    required this.liveId,
  });

  final _i12.Key? key;

  final String liveId;

  @override
  String toString() {
    return 'CreateMovementRouteArgs{key: $key, liveId: $liveId}';
  }
}

/// generated route for
/// [_i9.ProfilePage]
class ProfileRoute extends _i11.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i10.SingleProfilePage]
class SingleProfileRoute extends _i11.PageRouteInfo<SingleProfileRouteArgs> {
  SingleProfileRoute({
    _i12.Key? key,
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

  final _i12.Key? key;

  final String profileId;

  @override
  String toString() {
    return 'SingleProfileRouteArgs{key: $key, profileId: $profileId}';
  }
}
