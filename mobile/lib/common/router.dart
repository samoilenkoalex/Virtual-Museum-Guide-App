import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/common/screens/home_screen.dart';


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

const String homeScreen = '/home';
const String episodesRoute = '/episodes';

final globalNavigationKey = GlobalKey<NavigatorState>(debugLabel: 'global');

//todo: disabled for MVP
// final _shellNavigatorFilesKey = GlobalKey<NavigatorState>(debugLabel: 'files');

final goRouter = GoRouter(
  navigatorKey: globalNavigationKey,
  initialLocation: homeScreen,
  routes: [
    GoRoute(
      path: homeScreen,
      pageBuilder: (context, state) => _TransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
      ),
    ),
    // GoRoute(
    //   path: episodesRoute,
    //   builder: (context, state) {
    //     final extra = state.extra! as Map<dynamic, dynamic>;
    //
    //     return MultiBlocProvider(
    //       providers: [
    //         BlocProvider(
    //           create: (context) => SummarizeBloc(),
    //         ),
    //       ],
    //       child: EpisodeScreen(
    //         item: extra['item'],
    //       ),
    //     );
    //   },
    // ),
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
