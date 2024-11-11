import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/screens/home_screen.dart';

import '../features/description/cubit/description_cubit.dart';
import '../features/description/screens/description_screen.dart';

/* * * * * * * * * * * *
*
* /home
* /pages
*     /pages/1
*     /pages/2
*     ...
*     /pages/test
*
* * * * * * * * * * * */

const String homeRoute = '/home';
const String descriptionRoute = '/episodes';

final globalNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'global');

//todo: disabled for MVP

final goRouter = GoRouter(
  navigatorKey: globalNavigationKey,
  initialLocation: homeRoute,
  routes: [
    GoRoute(
      path: homeRoute,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: descriptionRoute,
      builder: (context, state) {
        final extra = state.extra! as Map<dynamic, dynamic>;

        return BlocProvider(
          create: (context) => DescriptionCubit(descriptionRepository: RepositoryProvider.of(context)),
          child: DescriptionScreen(
            artwork: extra['artwork'],
          ),
        );
      },
    ),
  ],
);

class _TransitionPage extends CustomTransitionPage<dynamic> {
  _TransitionPage({super.key, required super.child})
      : super(
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
