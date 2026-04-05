import 'package:fiestapp/feature/auth/presentation/pages/create_profile_view.dart';
import 'package:fiestapp/feature/auth/presentation/pages/login_view.dart';
import 'package:fiestapp/feature/auth/presentation/pages/register_view.dart';
import 'package:fiestapp/feature/event/presentation/pages/add-event.page.dart';
import 'package:fiestapp/feature/event/presentation/pages/details.page.dart';
import 'package:fiestapp/feature/event/presentation/pages/home.page.dart';
import 'package:fiestapp/feature/invitation/presentation/pages/invitation.page.dart';
import 'package:fiestapp/feature/splash/presentation/pages/splash_view.dart';
import 'package:fiestapp/feature/user/presentation/pages/profil.page.dart';
import 'package:go_router/go_router.dart';

import 'route_enum.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoute.splash.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: AppRoute.profil.path,
        name: AppRoute.profil.name,
        builder: (context, state) => const Profil(),
      ),
      GoRoute(
        path: AppRoute.details.path,
        name: AppRoute.details.name,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'];
          return Details(id: id!);
        },
      ),
      GoRoute(
        path: AppRoute.invitation.path,
        name: AppRoute.invitation.name,
        builder: (context, state) {
          // On récupère le token soit depuis les queryParameters (?token=...)
          // soit depuis le path si besoin. Ici on privilégie le queryParameter pour fiestapp://invitation?token=...
          final token = state.uri.queryParameters['token'];
          return Invitation(id: token!);
        },
      ),
      GoRoute(
        path: AppRoute.addEvent.path,
        name: AppRoute.addEvent.name,
        builder: (context, state) => const AddEvent(),
      ),
      GoRoute(
        path: AppRoute.createprofile.path,
        name: AppRoute.createprofile.name,
        builder: (context, state) => const CreateProfileView(),
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        builder: (context, state) => const RegisterView(),
      ),
    ],
  );
}
