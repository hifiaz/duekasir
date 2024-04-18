import 'package:due_kasir/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Home();
}

// @TypedGoRoute<ActivityRoute>(path: '/activity')
// class ActivityRoute extends GoRouteData {
//   const ActivityRoute();

//   @override
//   Widget build(BuildContext context, GoRouterState state) =>
//       const ActivityScreen();
// }
