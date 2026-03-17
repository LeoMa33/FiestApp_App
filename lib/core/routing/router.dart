import 'package:fiestapp/core/common_widgets/loading_screen/loading.page.dart';
import 'package:fiestapp/feature/auth/presentation/pages/register.page.dart';
import 'package:fiestapp/feature/event/presentation/pages/add-event.page.dart';
import 'package:fiestapp/feature/event/presentation/pages/details.page.dart';
import 'package:fiestapp/feature/event/presentation/pages/home.page.dart';
import 'package:fiestapp/feature/invitation/presentation/pages/invitation.page.dart';
import 'package:fiestapp/feature/user/presentation/pages/profil.page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_enum.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.home.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/loading',
        name: 'loading',
        builder: (context, state) => const LoadingScreen(),
      ),
      GoRoute(
        path: AppRoute.profil.path,
        name: AppRoute.profil.name,
        builder: (context, state) => const Profil(),
      ),
      GoRoute(
        path: AppRoute.details.path,
        name: AppRoute.details.name,
        builder: (context, state) => const Details(),
      ),
      GoRoute(
        path: "${AppRoute.invitation.path}/:id",
        name: AppRoute.invitation.name,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return Invitation(id: id);
        },
      ),
      GoRoute(
        path: AppRoute.addEvent.path,
        name: AppRoute.addEvent.name,
        builder: (context, state) => const AddEvent(),
      ),
      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        builder: (context, state) => const Register(),
      ),
    ],
  );
});
